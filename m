Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262592AbTCMVyU>; Thu, 13 Mar 2003 16:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262581AbTCMVwc>; Thu, 13 Mar 2003 16:52:32 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37392 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262579AbTCMVw1>; Thu, 13 Mar 2003 16:52:27 -0500
Date: Thu, 13 Mar 2003 22:03:08 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: [2.4] init/do_mounts.c::rd_load_image() memleak
Message-ID: <20030313220308.A28040@flint.arm.linux.org.uk>
Mail-Followup-To: Oleg Drokin <green@linuxhacker.ru>, alan@redhat.com,
	linux-kernel@vger.kernel.org, viro@math.psu.edu
References: <20030313210144.GA3542@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030313210144.GA3542@linuxhacker.ru>; from green@linuxhacker.ru on Fri, Mar 14, 2003 at 12:01:44AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 14, 2003 at 12:01:44AM +0300, Oleg Drokin wrote:
> +	if (buf)
> +		kfree(buf);

kfree(NULL); is valid - you don't need this check.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

