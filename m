Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263098AbREWO24>; Wed, 23 May 2001 10:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263099AbREWO2q>; Wed, 23 May 2001 10:28:46 -0400
Received: from ns.suse.de ([213.95.15.193]:16398 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S263098AbREWO2g>;
	Wed, 23 May 2001 10:28:36 -0400
Date: Wed, 23 May 2001 16:27:39 +0200
From: Andi Kleen <ak@suse.de>
To: =?iso-8859-1?Q?christophe_barb=E9?= <christophe.barbe@lineo.fr>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: sk_buff destructor in 2.2.18
Message-ID: <20010523162739.A24463@gruyere.muc.suse.de>
In-Reply-To: <20010523161654.C7531@pc8.lineo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010523161654.C7531@pc8.lineo.fr>; from christophe.barbe@lineo.fr on Wed, May 23, 2001 at 04:16:54PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2001 at 04:16:54PM +0200, christophe barbé wrote:
> Hi all,
> 
> I'm trying to figure out how to use the destructor function in the skbuff
> object. 
> I've read (the source code and) the alan cox's article from linuxjournal
> but it refers to linux 2.0.
> Perhaps someone can tell me what's wrong in the following :

You can't use the destructor; it is already used by the main stack for socket
memory management.

-Andi
