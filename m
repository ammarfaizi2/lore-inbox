Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264575AbTLCNbx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 08:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264576AbTLCNbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 08:31:53 -0500
Received: from holomorphy.com ([199.26.172.102]:58573 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264575AbTLCNbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 08:31:52 -0500
Date: Wed, 3 Dec 2003 05:31:47 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: David Mart?nez Moreno <ender@debian.org>
Cc: linux-kernel@vger.kernel.org, clubinfo.servers@adi.uam.es
Subject: Re: Errors and later panics in 2.6.0-test11.
Message-ID: <20031203133147.GT8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	David Mart?nez Moreno <ender@debian.org>,
	linux-kernel@vger.kernel.org, clubinfo.servers@adi.uam.es
References: <200312031417.18462.ender@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312031417.18462.ender@debian.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 02:17:18PM +0100, David Mart?nez Moreno wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 	Hello again. I'm testing 2.6.0-test11 in one of my servers. In about a day or
> so under a web/FTP server load, the kernel starts to spit messages:
> Dec  2 22:07:25 ulises kernel: Bad page state at prep_new_page
> Dec  2 22:07:25 ulises kernel: flags:0x0102002c mapping:d50c8a28 mapped:0 count:1
> Dec  2 22:07:25 ulises kernel: Backtrace:
> Dec  2 22:07:25 ulises kernel: Call Trace:
> Dec  2 22:07:25 ulises kernel:  [bad_page+93/133] bad_page+0x5d/0x85
> Dec  2 22:07:25 ulises kernel:  [prep_new_page+50/81] prep_new_page+0x32/0x51
> Dec  2 22:07:25 ulises kernel:  [buffered_rmqueue+165/264] buffered_rmqueue+0xa5/0x108

Someone is freeing pages still in the pagecache.

What filesystem? What .config? Could you try CONFIG_DEBUG_PAGEALLOC?


-- wli
