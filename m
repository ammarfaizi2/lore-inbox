Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030376AbVKHWIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030376AbVKHWIr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 17:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030377AbVKHWIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 17:08:47 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:19110 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030376AbVKHWIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 17:08:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=fxssO2b+ozf66Bv4R/dl89Ax9W/1HsLp9yrMyaO3CpouIO2hirCEqBmC87aIeQHC+xmrzJMDDlUZSWmxOqp1ep3jK99Itmxz0FuZ3c/UlRhDl95WP6GHa2lImJqo5fD9Pvp/xHf+OnANA6i6wUrCQaLWS4yXRmT66F04SJebetI=
Subject: Re: Creating new System.map with modules symbol info
From: Chris Largret <largret@gmail.com>
Reply-To: largret@gmail.com
To: Adayadil Thomas <adayadil.thomas@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <fb7befa20511081345l497846abla28f978fc4e45442@mail.gmail.com>
References: <fb7befa20511081304sec70208l5d1a464e5af78f58@mail.gmail.com>
	 <1131484787.5520.3.camel@shogun.daga.dyndns.org>
	 <fb7befa20511081345l497846abla28f978fc4e45442@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 08 Nov 2005 14:08:29 -0800
Message-Id: <1131487709.5732.6.camel@shogun.daga.dyndns.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 Dropline GNOME 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-08 at 16:45 -0500, Adayadil Thomas wrote:
> Thanks for the reply.
> 
> Usage of mksysmap is --
> mksysmap vmlinux System.map
> 
> How do I specify the module which is not included in the kernel ?
> Is that possible ?

you could do:

nm -n /path/to/module.ko | grep -v '\( [aUw] \)\|\(__crc_\)\|\( \
$[adt]\)'>/path/to/module.map

This is essentially what mksysmap does, except with the ability to
define 'nm' locations. This isn't really a file that could be used in
place of the System.map file though. At least not if I understand the
purpose of it.

The System.map file is used to keep track of symbols in the kernel. I
believe the module symbols can be traced with the aid of some of the
debug kernel configuration options.

--
Chris Largret <http://daga.dyndns.org>

