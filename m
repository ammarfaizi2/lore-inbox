Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262214AbSLMLid>; Fri, 13 Dec 2002 06:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262067AbSLMLid>; Fri, 13 Dec 2002 06:38:33 -0500
Received: from mail.iwr.uni-heidelberg.de ([129.206.104.30]:20182 "EHLO
	mail.iwr.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S262023AbSLMLic>; Fri, 13 Dec 2002 06:38:32 -0500
Date: Fri, 13 Dec 2002 12:46:15 +0100 (CET)
From: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>
To: "David S. Miller" <davem@redhat.com>
cc: dlstevens@us.ibm.com, <matti.aarnio@zmailer.org>, <niv@us.ibm.com>,
       <alan@lxorguk.ukuu.org.uk>, <stefano.andreani.ap@h3g.it>,
       <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>
Subject: Re: R: Kernel bug handling TCP_RTO_MAX?
In-Reply-To: <20021212.225912.115906105.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0212131233220.11129-100000@kenzo.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Dec 2002, David S. Miller wrote:

> This is well understood, the problem is that BSD's coarse timers are
> going to cause all sorts of problems when a Linux stack with a reduced
> MIN RTO talks to it.

Sorry to jump into the discussion without a good understanding of inner 
workings of TCP, I just want to share my view as a possible user of this:
one of the messages at the beginning of the thread said that this would be 
useful on a closed network and I think that this point was overlooked.

Think of a closed network with only Linux machines on it (world
domination, right :-))  like a Beowulf cluster, web frontends talking to
NFS fileservers, web frontends talking to database backends, etc. Again as 
proposed earlier, border hosts (those connected to both the closed 
network and outside one) could change their communication parameters based 
on device or route and this would become an internal affair that would not 
affect communication with other stacks.

I don't want to suggest to make this the default behaviour; rather, have 
it a parameter that can be changed by the sysadmin and have the current 
value as default.

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De

