Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261953AbVCUVFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbVCUVFI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 16:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbVCUVCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 16:02:52 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:18080 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261898AbVCUUwe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 15:52:34 -0500
Subject: Re: [patch 1/2] fork_connector: add a fork connector
From: Ram <linuxram@us.ibm.com>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Jay Lan <jlan@engr.sgi.com>,
       Erich Focht <efocht@hpce.nec.com>, Gerrit Huizenga <gh@us.ibm.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>, Greg KH <greg@kroah.com>
In-Reply-To: <1111409303.8329.16.camel@frecb000711.frec.bull.fr>
References: <1111050243.306.107.camel@frecb000711.frec.bull.fr>
	 <200503170856.57893.jbarnes@engr.sgi.com>
	 <20050318003857.4600af78@zanzibar.2ka.mipt.ru>
	 <200503171405.55095.jbarnes@engr.sgi.com>
	 <1111409303.8329.16.camel@frecb000711.frec.bull.fr>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1111438349.5860.27.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 21 Mar 2005 12:52:30 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-21 at 04:48, Guillaume Thouvenin wrote:
> ChangeLog:
> 
>   - Remove the global cn_fork_lock and replace it by a per CPU 
>     counter. 
>   - The processor ID has been added in the data part of the message.
>     Thus datas sent in a message are: "CPU_ID PARENT_PID CHILD_PID"
> 
>   Those modifications were done to be more scalable because, as
> mentioned by Jesse Barnes, the global cn_fork_lock won't work well on a
> large CPU system.
> 
>   This patch applies to 2.6.11-mm4.
Guillaume,

     If a bunch of applications are listening for fork events, 
     your patch allows any application to turn off the 
     fork event notification?  Is this the right behavior?

     Should'nt it turn off the fork-event notification when 
     the number of listeners become zero?
  
RP


 

