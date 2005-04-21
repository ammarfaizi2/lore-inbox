Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVDUNse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVDUNse (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 09:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbVDUNse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 09:48:34 -0400
Received: from nevyn.them.org ([66.93.172.17]:65239 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261379AbVDUNsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 09:48:32 -0400
Date: Thu, 21 Apr 2005 09:48:31 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: strange incremental patch size [2.6.12-rc2 to 2.6.12-rc3]
Message-ID: <20050421134831.GA30943@nevyn.them.org>
Mail-Followup-To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
	linux-kernel@vger.kernel.org
References: <1617591394.20050421123259@dns.toxicfilms.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617591394.20050421123259@dns.toxicfilms.tv>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2005 at 12:32:59PM +0200, Maciej Soltysiak wrote:
> Hi,
> 
> These are the sizes of rc2 and rc3 patches
> 
> # ls -la patch-2.6.12*
> -rw-r--r--  1 root src 18011382 Apr  4 18:50 patch-2.6.12-rc2
> -rw-r--r--  1 root src 19979854 Apr 21 02:29 patch-2.6.12-rc3
> 
> Let us make an incremental patch from rc2 to rc3
> 
> # interdiff patch-2.6.12-rc2 patch-2.6.12-rc3 >x
> 
> Let us see how big it is.
> # ls -ld x
> -rw-r--r--  1 root src 37421924 Apr 21 12:28 x
> 
> How come interdiff from rc2 (18MB) to rc3 (20MB) gave me
> 37MB worth of patch-code ? I would expect something about
> 2MB but 40MB ?

Try interdiff -p1?

-- 
Daniel Jacobowitz
CodeSourcery, LLC
