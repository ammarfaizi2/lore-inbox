Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbULBMeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbULBMeH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 07:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbULBMeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 07:34:07 -0500
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:38834 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S261598AbULBMd4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 07:33:56 -0500
Message-ID: <41AF0BA5.5080901@blue-labs.org>
Date: Thu, 02 Dec 2004 07:33:41 -0500
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041012
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] misleading error message
References: <001101c4d715$25a59470$af00a8c0@BEBEL> <Pine.LNX.4.61.0411302251180.3635@dragon.hygekrogen.localhost> <Pine.LNX.4.53.0411302310080.31695@yvahk01.tjqt.qr> <Pine.LNX.4.61.0411302328450.3635@dragon.hygekrogen.localhost> <Pine.LNX.4.53.0411302329550.13758@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0411302329550.13758@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Random side thoughts..

a) is there a simple way to search for symbols in a running kernel's 
memory area that
b) can differentiate between module and static, and if so
c) is there an interest in a tiny tool that scripts  could use to 
determine existing support?

I want to be able to request information about a whooplesnoople without 
it triggering a module load request, to determine if it's compiled in 
statically.  I want to be able to distinguish static a static 
whooplesnoople from a modularly loaded whooplesnoople.

i.e.
Scott ~$ kernfunctionexists "iptables"
builtin

Other possible values:
module
not found

The tool would do the work of doing a lookup on "iptables" to match it 
with a certain name.  I.e "irda" would be resolved to a known proper 
irda_function_name() value.

The purpose of this is not to be able to research any given function 
name in the kernel, but to look for major support functions such as 
iptables.

David

