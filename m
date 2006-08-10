Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWHJTKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWHJTKc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWHJTKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:10:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:50439 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750873AbWHJTKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:10:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S2/e9d9r7E7Zpp744QIsp4ZhKf22/euYyo38OJP2J4Ngsg5mIkWYTHGrO+GFPC+P7ODuiTu18gU+iKLgscuCoiQVg50QLJYiXhzEdm1hpPd2i1QW7Tg19l/1Rxoal332S8g854odVGRhGe4CP5fVmP2QQFFyvmMVIVTiOFne46A=
Message-ID: <62b0912f0608101210k708ff3f5ua6af62e751fef7c7@mail.gmail.com>
Date: Thu, 10 Aug 2006 21:10:29 +0200
From: "Molle Bestefich" <molle.bestefich@gmail.com>
To: "John Stoffel" <john@stoffel.org>
Subject: Re: ext3 corruption
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <17627.23159.236724.190546@stoffel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <62b0912f0607131332u5c390acfrd290e2129b97d7d9@mail.gmail.com>
	 <62b0912f0608081647p2d540f43t84767837ba523dc4@mail.gmail.com>
	 <Pine.LNX.4.61.0608090723520.30551@chaos.analogic.com>
	 <62b0912f0608090822n2d0c44c4uc33b5b1db00e9d33@mail.gmail.com>
	 <1A5F0A2F95110B3F35E8A9B5@dhcp-2-206.wgops.com>
	 <62b0912f0608091128n4d32d437h45cf74af893dc7c8@mail.gmail.com>
	 <20060810030602.GA29664@mail>
	 <62b0912f0608100248w2b3c2243xec588aee8c5a9079@mail.gmail.com>
	 <17627.23159.236724.190546@stoffel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Stoffel wrote:
> Molle> And voila, that difficult task of assessing in which order to
> Molle> do things is out of the hands of distros like Red Hat, and into
> Molle> the hands of those people who actually make the binaries.
>
> *bwah hah hah!*

No need to ridicule :-).
After all, I'm just saying that there's got to be a simpler, stabler
and more transparent way than to have all this logic sit in shell
scripts.

> So what happens when two packages, call them A and B,
> have a circular dependency on each other?  Who wins then?

They both get terminated at *exactly* the same time :-)... Nah, just kidding.

In that case, I imagine either
a) the system will log errors to syslog and pick a random order, or
b) the system will refuse to shutdown, politely returning back a
message to the user space tool that asked for the shutdown, saying
"there's an inconsistency in the ordering rules, please fix that
first".  They guy who tapped in "shutdown" would have to kill one of
the processes manually.  (And probably also upgrade the affected
software, or file a bug report, or whatever.)

I Googled for a similar software construct, and came upon the SCM in Windows.
Seems you can make Windows drivers and system services depend on each other.
In the case where there exists a circular dependency, the SCM refuses
to even start the affected services.

So there's a third possibility.
