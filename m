Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278429AbRJSPT6>; Fri, 19 Oct 2001 11:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278427AbRJSPTs>; Fri, 19 Oct 2001 11:19:48 -0400
Received: from cs6625129-123.austin.rr.com ([66.25.129.123]:49420 "HELO
	dragon.taral.net") by vger.kernel.org with SMTP id <S278426AbRJSPTj> convert rfc822-to-8bit;
	Fri, 19 Oct 2001 11:19:39 -0400
Date: Fri, 19 Oct 2001 10:21:36 -0500
From: Taral <taral@taral.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Patrick Mochel <mochelp@infinity.powertie.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] New Driver Model for 2.5
Message-ID: <20011019102136.C30774@taral.net>
In-Reply-To: <3BCE7568.1DAB9FF0@mandrakesoft.com> <20011018121318.17949@smtp.adsl.oleane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2001 at 02:13:18PM +0200, Benjamin Herrenschmidt wrote:
> I would add to the generic structure device, a "uuid" string field.
> This field would contain a "munged" unique identifier composed of
> the bus type followed which whatever bus-specific unique ID is
> provided by the driver. If the driver don't provide one, it defaults
> to a copy of the busID.
> 
> What I have in mind here is to have a common place to look for the
> best possible unique identification for a device. Typical example are
> ieee1394 hard disks which do have a unique ID, and so can be properly
> tracked between insertion removal.

Actually, if this field were to be added, I think it would be far better
to have it be NULL in the case where there is no ID which can be
expected to remain the same on insert/remove. Otherwise we might have
people getting very confused when someone removes device A and adds
device B and they end up with the same "unique id" because neither one
has a real unique id.

-- 
Taral <taral@taral.net>
This message is digitally signed. Please PGP encrypt mail to me.
"Any technology, no matter how primitive, is magic to those who don't
understand it." -- Florence Ambrose
