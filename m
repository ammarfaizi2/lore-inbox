Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbVISLjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbVISLjn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 07:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbVISLjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 07:39:43 -0400
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:30103 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S932081AbVISLjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 07:39:42 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17197.15183.235861.655720@gargle.gargle.HOWL>
Date: Sun, 18 Sep 2005 14:02:55 +0400
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Newsgroups: gmane.comp.file-systems.reiserfs.general,gmane.linux.kernel
In-Reply-To: <200509171416.21047.vda@ilport.com.ua>
References: <432AFB44.9060707@namesys.com>
	<200509171416.21047.vda@ilport.com.ua>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko writes:
 > On Friday 16 September 2005 20:05, Hans Reiser wrote:
 > > All objections have now been addressed so far as I can discern.
 > 
 > Random observation:
 > 
 > You can declare functions even if you never use them.
 > Thus here you can avoid using #if/#endif:
 > 
 > #if defined(REISER4_DEBUG) || defined(REISER4_DEBUG_MODIFY) || defined(REISER4_DEBUG_OUTPUT)
 > int znode_is_loaded(const znode * node /* znode to query */ );
 > #endif

It's other way around: declaration is guarded by the preprocessor
conditional so that nobody accidentally use znode_is_loaded() outside of
the debugging mode.

 > 
 > --
 > vda
 > 

Nikita.
