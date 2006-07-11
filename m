Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWGKOCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWGKOCi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 10:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWGKOCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 10:02:38 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:54683 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750797AbWGKOCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 10:02:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lTyb9S9gJS/qpt4usXL6m080epOMdczLEYaQaKJVHI1Ms9ozcyDwYiX50pyyahZnKlu50oCpq6sDgVgmAM4XgXMsbhQrxrMGDNM0v8MgBq/WWKUuHTnfjNtSijGICND3Z/2eai1VNqOMqwt3m5gdJLSxSKf+6faIdYIUzxE+0hQ=
Message-ID: <b0943d9e0607110702p60f5bf3fg910304bfe06ec168@mail.gmail.com>
Date: Tue, 11 Jul 2006 15:02:37 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [PATCH 00/10] Kernel memory leak detector 0.8
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0607110649s464840a9sf04c7537809436b1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060710220901.5191.66488.stgit@localhost.localdomain>
	 <6bffcb0e0607110527x4520d5bbne8b9b3639a821a18@mail.gmail.com>
	 <b0943d9e0607110556v50185b9i5443dabedba46152@mail.gmail.com>
	 <6bffcb0e0607110617g36f7123dm2b5f0e88b10cbcaa@mail.gmail.com>
	 <b0943d9e0607110628w60a436f7t449714eb4a3200ca@mail.gmail.com>
	 <6bffcb0e0607110649s464840a9sf04c7537809436b1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> System hangs when I try "cat /sys/kernel/debug/memleak". Here is what
> I found in a log file.

Can you disable DEBUG_MEMLEAK_ORPHAN_FREEING? That's mainly used for
debugging but I don't think it is was causing the hang. I haven't
changed the locking mechanism since version 0.7 but maybe some other
bug made its way in.

-- 
Catalin
