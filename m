Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265817AbUGHG6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265817AbUGHG6V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 02:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265820AbUGHG6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 02:58:21 -0400
Received: from linuxhacker.ru ([217.76.32.60]:36829 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S265817AbUGHG6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 02:58:20 -0400
Date: Thu, 8 Jul 2004 09:57:57 +0300
From: Oleg Drokin <green@clusterfs.com>
To: Ian Kent <raven@themaw.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, braam@clusterfs.com
Subject: Re: [3/9] Lustre VFS patches for 2.6
Message-ID: <20040708065757.GQ5619@linuxhacker.ru>
References: <20040707124732.GA25917@clusterfs.com> <Pine.LNX.4.58.0407080821140.30806@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0407080821140.30806@wombat.indigo.net.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Jul 08, 2004 at 08:27:26AM +0800, Ian Kent wrote:
> > +	intent_init(&nd.intent.open, IT_OPEN);
> >  	nd.intent.open.flags = FMODE_READ;
> > -	error = __user_walk(library, LOOKUP_FOLLOW|LOOKUP_OPEN, &nd);
> > +	error = user_path_walk_it(library, &nd);
> I don't have source available right now (I'll check later) but droping 
> LOOKUP_FOLLOW might break autofs4.

It is not dropped,
user_path_walk_it is defined like this:
#define user_path_walk_it(name,nd) \
        __user_walk_it(name, LOOKUP_FOLLOW, nd)

Bye,
    Oleg
