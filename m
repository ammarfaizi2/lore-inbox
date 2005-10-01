Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbVJAWZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbVJAWZd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 18:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbVJAWZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 18:25:33 -0400
Received: from qproxy.gmail.com ([72.14.204.196]:46702 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750876AbVJAWZc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 18:25:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=C0bO618PK9nnmRxsNmaxdVpP8d/R71+0bNxQc6pfO4VyQjlvQLAlrU7woNfeaTbUVvC3KVKLqVMu6vdgFI7S9KzJ5fY01BeEgsQMElPYV96/Zn9aNdGxAGDZx2YAejdVon/gHdk73DT4M8tML1uQUpwM0LHSHAisiUyev8w3XFI=
Date: Sun, 2 Oct 2005 02:36:40 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Grant Coady <grant_lkml@dodo.com.au>
Cc: Jean Delvare <khali@linux-fr.org>, Deepak Saxena <dsaxena@plexity.net>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [HWMON] kmalloc + memset -> kzalloc conversion
Message-ID: <20051001223640.GA18641@mipter.zuzino.mipt.ru>
References: <20051001072630.GJ25424@plexity.net> <20051001224604.484ef912.khali@linux-fr.org> <ln0uj11mbrnrrah1amu53dmno6bprf560g@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ln0uj11mbrnrrah1amu53dmno6bprf560g@4ax.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2005 at 07:45:36AM +1000, Grant Coady wrote:
> On Sat, 1 Oct 2005 22:46:04 +0200, Jean Delvare <khali@linux-fr.org> wrote:
> >> -	if (!(data = kmalloc(sizeof(struct adm1021_data), GFP_KERNEL))) {
> >> +	if (!(data = kzalloc(sizeof(struct adm1021_data), GFP_KERNEL))) {
> 
> 	if (!(data = kzalloc(sizeof(*data), GFP_KERNEL))) {
> 
> instead?

One thing at a time. And leave sizeof(*p) vs sizeof(struct foo) to
maintainer, OK?

