Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269594AbUJWEs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269594AbUJWEs5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 00:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269320AbUJWEsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 00:48:50 -0400
Received: from [211.58.254.17] ([211.58.254.17]:55442 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S269594AbUJWEoZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 00:44:25 -0400
Date: Sat, 23 Oct 2004 13:44:20 +0900
From: Tejun Heo <tj@home-tj.org>
To: rusty@rustcorp.com.au, mochel@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH] Per-device parameter support (4/16)
Message-ID: <20041023044420.GR3456@home-tj.org>
References: <20041023042550.GE3456@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041023042550.GE3456@home-tj.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Oops, I've used explanation for dp_3 again for dp_4.  Sorry.

On Sat, Oct 23, 2004 at 01:25:51PM +0900, Tejun Heo wrote:
>  dp_04_module_param_ranged.diff
> 
>  This is the 4th patch of 16 patches for devparam.

 This patch adds min and max fields of long type to struct
kernel_param and adds range checking for integer, charp and array
parameters.  Also, struct kparam_string isn't necessary anymore as we
can use max field instead.  I think this simple range-checking can
remove a lot of dulicated codes from drivers.

-- 
tejun
