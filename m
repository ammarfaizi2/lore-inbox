Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbVHRUBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbVHRUBx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 16:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbVHRUBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 16:01:52 -0400
Received: from main.gmane.org ([80.91.229.2]:16268 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932418AbVHRUBv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 16:01:51 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: egallego@telefonica.net (Emilio =?utf-8?Q?Jes=C3=BAs?= Gallego Arias)
Subject: Re: Environment variables inside the kernel?
Date: Thu, 18 Aug 2005 21:43:31 +0200
Message-ID: <87wtmjhvz0.fsf@telefonica.net>
References: <4fec73ca050818084467f04c31@mail.gmail.com>
	<m2ek8r5hhh.fsf@Douglas-McNaughts-Powerbook.local>
	<wn5slx75cjs.fsf@linhd-2.ca.nortel.com>
	<4fec73ca05081811488ec518e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
Cc: glalejos@gmail.com
X-Gmane-NNTP-Posting-Host: 89.red-83-44-14.pooles.rima-tde.net
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50 (gnu/linux)
Cancel-Lock: sha1:9TqRYyPU2oHXhgIikPi3ee/w5QQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillermo López Alejos <glalejos@gmail.com> writes:

> Whoa!, I did not expect so many replies. Thank you for your answers.
>
> The thing is that the Computer Architecture area of the University I
> am studying at is developing a parallel filesystem. Currently it works
> as a stand-alone program (this is why it uses resources like
> environment variables), and I have been told to integrate it in the
> Linux kernel.
>
> I have to justify changes on this filesystem code (like avoiding the
> use of environment variables) to my tutor. In this case I needed to
> find why it is not possible to use environment variables in kernel
> space.
>
> I was looking for a reference documentation which give a definition of
> environment variables that exclude their use inside the kernel, or,
> simply, I expected to find a design decision to justify this. But I
> think I have enough information with your answers, I will be able to
> elaborate a satisfactory conclusion.

A good reference is in Debian Policy Section 9.9, where it is stated:

A program must not depend on environment variables to get reasonable
defaults. (That's because these environment variables would have to be
set in a system-wide configuration file like /etc/profile, which is
not supported by all shells.)

Although this is not applicable to the kernel, goggling about this
section of the Debian Policy will give you some arguments against
environment variables in general.


