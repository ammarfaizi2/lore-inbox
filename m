Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268541AbUJDWaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268541AbUJDWaE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 18:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268693AbUJDW1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 18:27:35 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:63498 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268541AbUJDVgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 17:36:01 -0400
Date: Mon, 4 Oct 2004 22:35:54 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Jeff V. Merkey" <jmerkey@drdos.com>
Cc: linux-kernel@vger.kernel.org, jmerkey@comcast.net
Subject: Re: 2.6.9-rc2-mm4 stat -f sickness
Message-ID: <20041004223554.D21216@flint.arm.linux.org.uk>
Mail-Followup-To: "Jeff V. Merkey" <jmerkey@drdos.com>,
	linux-kernel@vger.kernel.org, jmerkey@comcast.net
References: <4161B6AF.1010705@drdos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4161B6AF.1010705@drdos.com>; from jmerkey@drdos.com on Mon, Oct 04, 2004 at 02:46:39PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2004 at 02:46:39PM -0600, Jeff V. Merkey wrote:
> In 2.6.9-rc2-mm4 the command "stat -f /dev/<device>" always returns
> EXT2_SUPER_MAGIC and other bogus information even if other filesystems
> are mounted on the device.  

Please read the statfs manpage carefully.  You will find that statfs
does not report the filesystem type found inside the "path" you asked
for, but the filesystem type _containing_ the path.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
