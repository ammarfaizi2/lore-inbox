Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263105AbREWOjP>; Wed, 23 May 2001 10:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263106AbREWOiz>; Wed, 23 May 2001 10:38:55 -0400
Received: from mail.inup.com ([194.250.46.226]:24595 "EHLO mailhost.lineo.fr")
	by vger.kernel.org with ESMTP id <S263105AbREWOiu>;
	Wed, 23 May 2001 10:38:50 -0400
Date: Wed, 23 May 2001 16:37:58 +0200
From: =?ISO-8859-1?Q?christophe_barb=E9?= <christophe.barbe@lineo.fr>
To: Andi Kleen <ak@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: sk_buff destructor in 2.2.18
Message-ID: <20010523163758.C7823@pc8.lineo.fr>
In-Reply-To: <20010523161654.C7531@pc8.lineo.fr> <20010523162739.A24463@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <20010523162739.A24463@gruyere.muc.suse.de>; from ak@suse.de on Wed, May 23, 2001 at 16:27:39 +0200
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems to not be the case, because my destructor is called.
Could you point me the code where you think this method is already used?

Thank you for your answer,
Christophe


On Wed, 23 May 2001 16:27:39 Andi Kleen wrote:
> On Wed, May 23, 2001 at 04:16:54PM +0200, christophe barbé wrote:
> > Hi all,
> > 
> > I'm trying to figure out how to use the destructor function in the
> skbuff
> > object. 
> > I've read (the source code and) the alan cox's article from
> linuxjournal
> > but it refers to linux 2.0.
> > Perhaps someone can tell me what's wrong in the following :
> 
> You can't use the destructor; it is already used by the main stack for
> socket
> memory management.
> 
> -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
-- 
Christophe Barbé
Software Engineer - christophe.barbe@lineo.fr
Lineo France - Lineo High Availability Group
42-46, rue Médéric - 92110 Clichy - France
phone (33).1.41.40.02.12 - fax (33).1.41.40.02.01
http://www.lineo.com

