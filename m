Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262971AbVDBCbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262971AbVDBCbM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 21:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262981AbVDBCbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 21:31:12 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:7522 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262971AbVDBCbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 21:31:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=srPBpSLwW9Z1L5pv2mCmeWiTGDTVBan8UEqX7VWEQBDlxTskr/b0AA54jxhByom6E2G5do8Ju6k5CB7qtvRQ+fWJ4Br7U6UpKd2ncarakQnBYq1F2Ia/AQmBuGxr3KtZkoNm/MG3hGuUwLY2/M7Yv4CfOTOx+CDZZbj3i2owP6w=
Message-ID: <9e47339105040118312ba5b356@mail.gmail.com>
Date: Fri, 1 Apr 2005 21:31:05 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: "K.R. Foley" <kr@cybsft.com>
Subject: Re: 2.6.12-rc1 won't boot if SCSI drivers are selected as modules
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <424D3BDD.5010001@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <424D3BDD.5010001@cybsft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 1, 2005 7:17 AM, K.R. Foley <kr@cybsft.com> wrote:
> I have an old Dell Precision 620 workstation with dual PIII 933's and
> 512 Mb memory. It also uses AIC-7899P U160/m SCSI controllers with one
> U160 drive (boot drive) and one slower 18 Gb. I have been running many
> different variants of the kernel on this system for quite some time with
> much success. However, no amount of gnashing of teeth or pulling of hair
> have been able to get this system to boot ANY 2.6.12-rc1 (including
> 2.6.12-rc1 vanilla, 2.6.12-rc1-mm3 and various RT patches) variant when
> the SCSI drivers are selected as modules (which is the way that I have
> always done it). Last night I built all of the necessary drivers into
> the kernel and the system boots fine.

I am also seeing this but not on every boot. My work around is to add
a 'sleep 2' to the nash script after the modules are loaded. Compling
everything in also worked.

This is discussed in the thread: "current linus bk, error mounting
root". I believe the answer is that it is not a kernel problem,
instead the init scripts have to be fixed.

-- 
Jon Smirl
jonsmirl@gmail.com
