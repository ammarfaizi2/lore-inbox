Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264508AbRFTRda>; Wed, 20 Jun 2001 13:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264509AbRFTRdU>; Wed, 20 Jun 2001 13:33:20 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:6662 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S264508AbRFTRdK>; Wed, 20 Jun 2001 13:33:10 -0400
Date: Wed, 20 Jun 2001 14:32:55 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Pavel Machek <pavel@suse.cz>, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: spindown
In-Reply-To: <01062018523007.00439@starship>
Message-ID: <Pine.LNX.4.33.0106201407450.1376-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2001, Daniel Phillips wrote:

> BTW, with nominal 100,000 erases you have to write 10 terabytes
> to your 100 meg flash disk before you'll see it start to
> degrade.

That assumes you write out full blocks.  If you flush after
every byte written you'll hit the limit a lot sooner ;)

Btw, this is also a problem with your patch, when you write
out buffers all the time your disk will spend more time seeking
all over the place (moving the disk head away from where we are
currently reading!) and you'll end up writing the same block
multiple times ...

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

