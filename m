Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312455AbSDJKuL>; Wed, 10 Apr 2002 06:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312574AbSDJKuJ>; Wed, 10 Apr 2002 06:50:09 -0400
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:43018 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S312455AbSDJKuF>; Wed, 10 Apr 2002 06:50:05 -0400
Date: Wed, 10 Apr 2002 12:49:56 +0200
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: Emmanuel Michon <emmanuel_michon@realmagic.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: module programming smp-safety howto?
Message-ID: <20020410104956.GD1465@arthur.ubicom.tudelft.nl>
In-Reply-To: <7w7knf98gk.fsf@avalon.france.sdesigns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2002 at 12:03:23PM +0200, Emmanuel Michon wrote:
> I'm responsible for the development of a kernel module for Sigma
> Designs EM84xx PCI chips (MPEG2 and MPEG4 hardware decoder
> boards). It's working properly now, irq sharing and multiple board
> support is ok.
> 
> I would like to make it smp-safe.
> 
> For instance, I use at a place cli()/restore to implement something that
> looks like a critical section (first code path is in a ioctl, second
> in a irq top half). I guess this approach is wrong with smp.
> 
> Is there some documentation or howto about what changes compared
> to non-smp computers?

Run "make psdocs" in your kernel tree, and you'll find Rusty's
kernel-locking guide in Documentation/DocBook/ . If you don't have the
proper tools, you can also download it from
http://www.kernelnewbies.org/documents/ .

> Maybe a specific kernel module can be considered as a good model?

I found the 8139too driver a nice source for good programming practice
(thanks, Jeff!).


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Faculty
of Information Technology and Systems, Delft University of Technology,
PO BOX 5031, 2600 GA Delft, The Netherlands  Phone: +31-15-2783635
Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
