Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129429AbRCABjs>; Wed, 28 Feb 2001 20:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129438AbRCABiB>; Wed, 28 Feb 2001 20:38:01 -0500
Received: from zeus.kernel.org ([209.10.41.242]:51676 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129446AbRCAB2X>;
	Wed, 28 Feb 2001 20:28:23 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Boris Dragovic <lynx@falcon.etf.bg.ac.yu>
cc: linux-kernel@vger.kernel.org
Subject: Re: negative mod use count 
In-Reply-To: Your message of "Wed, 28 Feb 2001 20:58:06 BST."
             <200102281958.UAA13226@falcon.etf.bg.ac.yu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 01 Mar 2001 11:04:58 +1100
Message-ID: <20516.983405098@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2001 20:58:06 +0100, 
Boris Dragovic <lynx@falcon.etf.bg.ac.yu> wrote:
>what does negative module use count mean?

Either an extra MOD_DEC_USE_COUNT was issued (buggy code) or the module
has a can_unload() function.  When modules define a can_unload()
routine then the use count is always displayed as -1 because the module
decides if it can be unloaded.

