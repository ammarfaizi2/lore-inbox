Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318652AbSHLDQ3>; Sun, 11 Aug 2002 23:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318657AbSHLDQ2>; Sun, 11 Aug 2002 23:16:28 -0400
Received: from rj.sgi.com ([192.82.208.96]:21183 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S318652AbSHLDQ2>;
	Sun, 11 Aug 2002 23:16:28 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Unix-domain sockets - abstract addresses 
In-reply-to: Your message of "Sun, 11 Aug 2002 19:59:06 MST."
             <20020811.195906.107999483.davem@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 12 Aug 2002 13:20:09 +1000
Message-ID: <1160.1029122409@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Aug 2002 19:59:06 -0700 (PDT), 
"David S. Miller" <davem@redhat.com> wrote:
>I don't like this solution, please fix this right and get rid of the
>limitations at their source.
>
>If I name a module "foo" and this causes "fo" to become a defined
>CPP symbol in when compiling the sources for that module, that is
>completely broken!
>
>net/unix is just a trite example.  How about a driver for device "foo"
>that has a member "foo" in one of it's structures?  They have to get
>this undef thing too or rename their module, that's rediculious.

I think you misunderstood the problem.  Calling a driver "foo" does not
make "foo" a cpp symbol.  The problem here is that 'unix' is a driver
name and also a symbol that is defined by gcc.

