Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263400AbRFFIXs>; Wed, 6 Jun 2001 04:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263402AbRFFIX2>; Wed, 6 Jun 2001 04:23:28 -0400
Received: from AMontpellier-201-1-3-224.abo.wanadoo.fr ([193.252.1.224]:10489
	"EHLO microsoft.com") by vger.kernel.org with ESMTP
	id <S263400AbRFFIXW>; Wed, 6 Jun 2001 04:23:22 -0400
Subject: Re: Break 2.4 VM in five easy steps
From: Xavier Bestel <xavier.bestel@free.fr>
To: Derek Glidden <dglidden@illusionary.com>
Cc: Andrew Morton <andrewm@uow.edu.au>, Jeffrey "W." Baker <jwbaker@acm.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010605231908.A10520@illusionary.com>
In-Reply-To: <3B1D5ADE.7FA50CD0@illusionary.com>
	<Pine.LNX.4.33.0106051634540.8311-100000@heat.gghcwest.com>
	<3B1D927E.1B2EBE76@uow.edu.au>  <20010605231908.A10520@illusionary.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10 (Preview Release)
Date: 06 Jun 2001 10:19:30 +0200
Message-Id: <991815578.30689.1.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05 Jun 2001 23:19:08 -0400, Derek Glidden wrote:
> On Wed, Jun 06, 2001 at 12:16:30PM +1000, Andrew Morton wrote:
> > "Jeffrey W. Baker" wrote:
> > > 
> > > Because the 2.4 VM is so broken, and
> > > because my machines are frequently deeply swapped,
> > 
> > The swapoff algorithms in 2.2 and 2.4 are basically identical.
> > The problem *appears* worse in 2.4 because it uses lots
> > more swap.
> 
> I disagree with the terminology you're using.  It *is* worse in 2.4,
> period.  If it only *appears* worse, then if I encounter a situation
> where a 2.2 box has utilized as much swap as a 2.4 box, I should see the
> same results.  Yet this happens not to be the case. 

Did you try to put twice as much swap as you have RAM ? (e.g. add a 512M
swapfile to your box)
This is what Linus recommended for 2.4 (swap = 2 * RAM), saying that
anything less won't do any good: 2.4 overallocates swap even if it
doesn't use it all. So in your case you just have enough swap to map
your RAM, and nothing to really swap your apps.

Xav

