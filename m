Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263865AbTFYEk4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 00:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263921AbTFYEk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 00:40:56 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:24595 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263865AbTFYEk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 00:40:56 -0400
Date: Wed, 25 Jun 2003 06:55:04 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Shawn Starr <spstarr@sh0n.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Speeding up Linux kernel compiles using -pipe?
Message-ID: <20030625045504.GB1053@mars.ravnborg.org>
Mail-Followup-To: Shawn Starr <spstarr@sh0n.net>,
	linux-kernel@vger.kernel.org
References: <000001c33ad1$5c415ff0$030aa8c0@panic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001c33ad1$5c415ff0$030aa8c0@panic>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 12:22:13AM -0400, Shawn Starr wrote:
> Why aren't we using -pipe? It can significantly speed up compiles by not
> writing temp files (intermediate files).

Most architectures already uses -pipe - see arch/*/Makefile:

[sam@mars v2.5]$ ls arch/*/Makefile | xargs grep -l -- -pipe | wc -l
     17
[sam@mars v2.5]$ ls arch/*/Makefile | wc -l
     21


	Sam
