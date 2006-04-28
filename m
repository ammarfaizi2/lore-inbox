Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030310AbWD1L7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030310AbWD1L7F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 07:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWD1L7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 07:59:05 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:28063 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1030290AbWD1L7C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 07:59:02 -0400
Date: Fri, 28 Apr 2006 14:59:01 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: "David =?utf-8?B?R8OzbWV6?=" <david@pleyades.net>
cc: David Vrabel <dvrabel@cantab.net>, Francois Romieu <romieu@fr.zoreil.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: IP1000 gigabit nic driver
In-Reply-To: <20060428113755.GA7419@fargo>
Message-ID: <Pine.LNX.4.58.0604281458110.19801@sbz-30.cs.Helsinki.FI>
References: <20060427142939.GA31473@fargo> <20060427185627.GA30871@electric-eye.fr.zoreil.com>
 <445144FF.4070703@cantab.net> <20060428075725.GA18957@fargo>
 <84144f020604280358ie9990c7h399f4a5588e575f8@mail.gmail.com>
 <20060428113755.GA7419@fargo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Fri, 28 Apr 2006, David Gómezz wrote:
> Ok, i could take care of that, and it's a good way of getting my hands
> dirty with kernel programming ;). David, if it's ok to you i'll do the
> cleanup thing.

Here are some suggestions for coding style cleanups:

  - Use Lindet for initial formatting
  - Kill use of LINUX_VERSION_CODE macro for compatability
  - Kill obfuscating macros. For example, IPG_DEV_KFREE_SKB and 
    IPG_DEVICE_TYPE.
  - Move changelogs outside of source files
  - Convert kmalloc/memset to kzalloc and kcalloc
  - Remove redundant typecasts
  - Remove dead code
  - Use dev_{dbg,err,info,warn} for logging
  - Remove unnecessary curly braces
  - Use proper naming convention for things like Length and pPHYParam
  - Convert macro functions to static inline functions for type safety

				Pekka
