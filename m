Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264226AbUFRWok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264226AbUFRWok (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 18:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUFRWnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 18:43:15 -0400
Received: from smtp-out2.xs4all.nl ([194.109.24.12]:2566 "EHLO
	smtp-out2.xs4all.nl") by vger.kernel.org with ESMTP id S262138AbUFRWmj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 18:42:39 -0400
Date: Sat, 19 Jun 2004 00:42:19 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.local
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Sam Ravnborg <sam@ravnborg.org>, willy@w.ods.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] save kernel version in .config file
In-Reply-To: <20040618150535.6a421bdb.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.58.0406190036440.10292@scrub.local>
References: <20040617220651.0ceafa91.rddunlap@osdl.org>
 <20040618053455.GF29808@alpha.home.local> <20040618205602.GC4441@mars.ravnborg.org>
 <20040618150535.6a421bdb.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 18 Jun 2004, Randy.Dunlap wrote:

Did you test this with anything else than menuconfig?

> +		     (char *)sym->curr.val, ctime(&now));

Try to avoid poking around in that structure. First the value needs to be 
calculated with sym_calc_value() and then it can be accessed with 
sym_get_string_value().

bye, Roman
