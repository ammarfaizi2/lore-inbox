Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275949AbSIUWqf>; Sat, 21 Sep 2002 18:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275950AbSIUWqf>; Sat, 21 Sep 2002 18:46:35 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:23311 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S275949AbSIUWqe>;
	Sat, 21 Sep 2002 18:46:34 -0400
Date: Sat, 21 Sep 2002 15:51:09 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: problems building bzImage with 2.5.*
Message-ID: <20020921225109.GB28936@kroah.com>
References: <20020921183527.GL22811@kruhft.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020921183527.GL22811@kruhft.dyndns.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 21, 2002 at 11:35:27AM -0700, Burton Samograd wrote:
> Hi all,
> 
> I'm quite new to the list and I'm not sure if this has been posted
> already but I thought I would give it a shot. I've been trying to
> build the 2.5.* kernels (2.5.37 at the moment but this has happened
> with previous version as well) and when doing a make bzImage i keep
> getting the following error during the final linkage:

Enable CONFIG_HOTPLUG or downgrade your version of binutils.  That
should fix the symptom.

As to how to fix the problem, you have to dig to determine which driver
is trying to reference a pointer that is marked __exit.

Hope this helps,

greg k-h
