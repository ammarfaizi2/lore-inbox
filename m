Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbTISE0d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 00:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbTISE0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 00:26:33 -0400
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:60657 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S261249AbTISE0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 00:26:30 -0400
Date: Thu, 18 Sep 2003 21:26:21 -0700
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Ross Boylan <RossBoylan@stanfordalumni.org>, linux-kernel@vger.kernel.org,
       Manoj Srivastava <srivasta@debian.org>
Subject: Re: PROBLEM: Default initial config options all N
Message-ID: <20030919042621.GZ12620@wheat.boylan.org>
References: <20030918165905.GX12620@wheat.boylan.org> <16233.64980.415212.495182@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16233.64980.415212.495182@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.4i
From: Ross Boylan <RossBoylan@stanfordalumni.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 18, 2003 at 08:47:48PM +0200, Mikael Pettersson wrote:
> Ross Boylan writes:
>  > Please cc me on replies.
>  > 
>  > [1.] One line summary of the problem:  
>  > Defaults for oldconfig options not set correctly in recent 2.4 kernels
> 
> Define "correctly". Hint: it's user-dependent.

As I'm sure you're aware, defaults are not user-dependent; whether to
accept the default is user-dependent.

Correctly = appropriate default setting as determined by kernel
developers.  For all the new options to default to N requires both of
the following statements to be true:
1) All the defaults are properly N.
2) Defaults should be inconsistent with the textual help's
specification of what you should do if you're unsure.

1) seems unlikely and 2) is inconsistent with previous practice in the
kernel configuration, as well as inconsistent with reasonable
behavior.

> 
>  > [2.] Full description of the problem/report:
>  > Built 2.4.21 kernel, starting with config file from 2.4.20 and running
>  > oldconfig.  *All* new config options had default values of N.  The
>  > help text for the following options suggested "if unsure, pick Y":
>  > PF_KEY
>  > CONFIG_INET_AH
>  > CONFIG_INET_ESP
>  > CONFIG_INET_IPCOMP
>  > CONFIG_IP_NF_TFTP
>  > CONFIG_XFRM_USER
> 
> Not a bug.
> 
>  > Sample from the config dialog:
>  > 
>  > PF_KEY sockets (CONFIG_NET_KEY) [N/y/m/?] (NEW) ?
>  > 
>  > CONFIG_NET_KEY:
>  > 
>  >   PF_KEYv2 socket family, compatible to KAME ones.
>  >   They are required if you are going to use IPsec tools ported
>  >   from KAME.
>  > 
>  >   Say Y unless you know what you are doing.
>  > PF_KEY sockets (CONFIG_NET_KEY) [N/y/m/?] (NEW) y
> 
> Still not a bug. oldconfig stopped and asked you what to do,
> you checked the help text and chose Y.

Are you saying that oldconfig defaults to all N, but regular config
does something else?

I'd consider that undesirable behavior.  Whether it's a bug is a
philosophical question.

> 
> Option authors tend to want people to enable them (enable this
> cool feature!) but in real life, most are Ok to disable.

Are you saying option authors write the help text, but someone else
sets the default response?  So one may recommend Y while the  other
recommends N?  If so, that seems undesirable (and, to repeat, not
consistent with my earlier experiences).


> 
> If oldconfig were to choose Y for new options, then _that_
> would be a bug.
> 
