Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318951AbSICWKd>; Tue, 3 Sep 2002 18:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318958AbSICWKc>; Tue, 3 Sep 2002 18:10:32 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:38279 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S318951AbSICWKc>; Tue, 3 Sep 2002 18:10:32 -0400
Date: Tue, 3 Sep 2002 23:13:30 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: phillips@arcor.de, wli@holomorphy.com, rml@tech9.net,
       rusty@rustcorp.com.au, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [TRIVIAL PATCH] Remove list_t infection.
Message-ID: <20020903231330.C6848@kushida.apsleyroad.org>
References: <20020902060257.GO888@holomorphy.com> <20020901.232021.00308364.davem@redhat.com> <E17loBW-0004gM-00@starship> <20020902.030553.14354294.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020902.030553.14354294.davem@redhat.com>; from davem@redhat.com on Mon, Sep 02, 2002 at 03:05:53AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> A list node is markably different from "the list" itself.
> 
> A "list" is the whole of all the nodes on the list, not just one
> of them.

Quite.

And that is why there should be _two_ types:

     1. struct list
     2. struct list_node

With these two types, `list_add' et al. can actually _check_ that you
got the arguments the right way around.

-- Jamie
