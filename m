Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292419AbSCDPUz>; Mon, 4 Mar 2002 10:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292421AbSCDPUp>; Mon, 4 Mar 2002 10:20:45 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:15067 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S292419AbSCDPUc>; Mon, 4 Mar 2002 10:20:32 -0500
Date: Mon, 4 Mar 2002 16:20:31 +0100
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: Group membership problem
Message-ID: <20020304152031.GA14777@artax.karlin.mff.cuni.cz>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020304130241Z292330-889+117131@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020304130241Z292330-889+117131@vger.kernel.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have Slackware 7.1 with 2.4.16 kernel. And I have a user who is a member of 
> a number of groups. Linux can't grant access to the user if the group's 
> number he is member of is more than 32. For example if he is member of 32 
> groups - everything is O.K. , but when I make him a member of the 33-rd group 
> he will not be granted access to resource which is owned by that group. 
> Is there any limit in Linux for the number of groups to be member of?
> And how can I solve that problem?

Unfortunately there is. Secondary group list is soteed in task_struct in an
array. IIRC it's called groups and declared with NGROUPS elements, which is in
turn #defined 32. You can try and change it in the source.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
