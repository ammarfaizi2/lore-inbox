Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266560AbUBESEh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 13:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266561AbUBESEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 13:04:37 -0500
Received: from cpc1-cwma1-5-0-cust4.swan.cable.ntl.com ([80.5.120.4]:46299
	"EHLO dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S266560AbUBESEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 13:04:35 -0500
Subject: Re: [BUG] unsafe reset in ac97_codec.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1075998717.5204.1003.camel@cearnarfon>
References: <1075822947.5204.506.camel@cearnarfon>
	 <40216306.2010602@pobox.com>  <1075998717.5204.1003.camel@cearnarfon>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1076003988.15801.8.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 05 Feb 2004 17:59:49 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-02-05 at 16:31, Liam Girdwood wrote:
> I agree, but I think we need to be aware of the codec type before we do
> a register reset. This type of codec is now becoming popular in PDA's.

Sometimes we can't even find out but yes I agree

> I can see another problem with the current probe implementation.
> Currently it sends the register reset command without first checking the
> codec ready bit. This assumes that the AC97 link is up and completely
> working before probe is called.

It is (in theory) the job of the calling driver to ensure AC97 is up
before doing the reset part.

> I'll implement this if it's acceptable as I can test it on both types of
> codec.

Sounds right to me

