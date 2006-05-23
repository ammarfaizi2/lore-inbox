Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbWEWBHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWEWBHu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 21:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWEWBHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 21:07:50 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:3794 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751230AbWEWBHt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 21:07:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZDQnFqYnBm/GFFaZ5i67JaRD++WM33Hx1Wf11IO2/OsPQ9KJ0tH2LmZJ24dZ5jDIvbMhNX4H3Na+D3tX221+7eAiKXuXspIki6ES/l6um2JVUS0I1KnUbnUiZ3yF3lCeQMu7IrdiC2NbAP4GumBAYExck6eh82m0lGz1y1rV38U=
Message-ID: <305c16960605221807o756b8bafk408ce4dabc9eec67@mail.gmail.com>
Date: Mon, 22 May 2006 22:07:48 -0300
From: "Matheus Izvekov" <mizvekov@gmail.com>
To: fitzboy <fitzboy@iparadigms.com>
Subject: Re: tuning for large files in xfs
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44725A67.6090505@iparadigms.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <447209A8.2040704@iparadigms.com>
	 <305c16960605221530h68e8e3c5s849eb66f4881593e@mail.gmail.com>
	 <44725A67.6090505@iparadigms.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/06, fitzboy <fitzboy@iparadigms.com> wrote:
> Matheus Izvekov wrote:
> >
> > Why use a flesystem with just one file?? Why not use the device node
> > of the partition directly?
>
> I am not sure what you mean, could you elaborate?
>

If you have, say, a partition of size 2GB (lets call it sdc3), you can
use the device node /dev/sdc3 as if it was a 2GB file. Just configure
your program to use /dev/sdc3 instead of whatever you name your file
that is alone in this xfs filesystem. You could try that and see how
fast it goes.
