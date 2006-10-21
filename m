Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161113AbWJUVzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161113AbWJUVzh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 17:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161105AbWJUVzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 17:55:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:22872 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161101AbWJUVzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 17:55:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L67UTO8eDcOkVvj05zNNnXA+aSHATfXoRVXs3d7XjGJT8aTXdK7aIF7j5mUDXQKEtMGjDus7zZNdrjpitliSlZ5yTkhEeukJSdcrgEgk1TXajhDTDlWglHa0BqfcGap16G7htY/pj7P5kCbMIsDYrEGGZy3xcydblvticA0tOSo=
Message-ID: <a36005b50610211455t35b5a097r5f9f25ff9238cb46@mail.gmail.com>
Date: Sat, 21 Oct 2006 14:55:35 -0700
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Ben Greear" <greearb@candelatech.com>
Subject: Re: futex hang with rpm in 2.6.17.1-2174_FC5
Cc: "Dave Jones" <davej@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <453A622C.2020401@candelatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <453917C2.8010201@candelatech.com>
	 <20061021052423.GF21948@redhat.com> <453A5C9E.1070303@candelatech.com>
	 <20061021180005.GF30758@redhat.com> <453A622C.2020401@candelatech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/06, Ben Greear <greearb@candelatech.com> wrote:
> Well, you can do tricks with file handles so that they are automatically
> closed/deleted when
> a process exits, even with kill -9.

Nope, that cannot work.  The lock object must be visible in the
filesystem space.

The correct solution would be to use robust mutexes.  But, as Dave
said, it's easier said than implemented in rpm.
