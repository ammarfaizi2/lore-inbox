Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261208AbTCFXSg>; Thu, 6 Mar 2003 18:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261224AbTCFXSg>; Thu, 6 Mar 2003 18:18:36 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:65521 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S261208AbTCFXSf>; Thu, 6 Mar 2003 18:18:35 -0500
Date: Thu, 6 Mar 2003 15:28:50 -0800
From: Chris Wright <chris@wirex.com>
To: sudharsan vijayaraghavan <my_goal@rediffmail.com>
Cc: linux-kernel@vger.kernel.org, svijayar@cisco.com,
       narendiran_srinivasan@satyam.com
Subject: Re: fd_install question ??
Message-ID: <20030306152850.A11341@figure1.int.wirex.com>
Mail-Followup-To: sudharsan vijayaraghavan <my_goal@rediffmail.com>,
	linux-kernel@vger.kernel.org, svijayar@cisco.com,
	narendiran_srinivasan@satyam.com
References: <20030306224608.29991.qmail@webmail17.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030306224608.29991.qmail@webmail17.rediffmail.com>; from my_goal@rediffmail.com on Thu, Mar 06, 2003 at 10:46:08PM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* sudharsan  vijayaraghavan (my_goal@rediffmail.com) wrote:
>           f1 = get_empty_filp();
>           if (!f1)
>                   goto no_files;
> 
>           f2 = get_empty_filp();
>           if (!f2)
>                   goto close_f1;
> 
> -->      if (!f3)
> -->             goto close_f12

you don't get a new filp for f3.  f3 is going to remain as garbage.
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
