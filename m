Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293210AbSB1Jrx>; Thu, 28 Feb 2002 04:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293216AbSB1Jpt>; Thu, 28 Feb 2002 04:45:49 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:48392 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S293210AbSB1JoB>; Thu, 28 Feb 2002 04:44:01 -0500
Message-ID: <3C7DFB9C.6A9F41F5@aitel.hist.no>
Date: Thu, 28 Feb 2002 10:42:52 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.5-dj2 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: "Allo! Allo!" <lachinois@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel module ethics.
In-Reply-To: <F82zxvoEaZWNaBJjvmZ00001183@hotmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Allo! Allo!" wrote:
> 
> Hi,
> 
> The company for whom I work wants to make a linux driver for some of its
> hardware. On my side I would like the driver to be completely open sourced,
> and from a customer point of view, its a big plus (a real PITA to maintain
> closed sourced drivers). On the other hand, the company wants a clear way to
> make "profit" from the work while still catering to it's customers whish to
> recompile the driver for just about any kernel version.

Make profit by selling hardware!  And by selling support - i.e.
customer wants the driver customized in some way, but don't want
to do it himself for fear of screwing up or having to
constantly track changing kernels.
 
> Here is what they propose... I do not know if what they are proposing is
> "going too far" regarding kernel module ethics, but I thought I'd ask the
> question here and see what other people think.
> 
> The hardware needs a firmware to run. Since this firmware is under NDA, the
> first compromise is to write the main part of the driver GPL but keep the
> firmware of the card in binary format. The driver can then load the firmware
> separately and this should not infringe on the GPL and I'm quite ok with
> this requirement. Now the problem is that any of our competitor's cards will
> work with the same closed sourced firmware and GPL engine. In pure
> capitalist thinking, the company finds this particularly troublesome...

How can a closed-source driver help you?  Even such a driver may be
pirated and used on the competitors card.  But you choose to trust
people in that situation.  If you trust people that much you might
as well release an open-source driver with a clause that it may only
be used with _your_ company's cards.  Or provide the _firmware_
with a strict licence and trust they don't pirate that.

The ideal way (for us customers) is if your company and the others with
similiar hardware agree on sharing the development cost of a 
GPL driver.  Nobody loose from paying for a driver the others can use.
Capitalist competition is still possible:
* extra features, quality & reliability are selling points
* pricing, advertising
* trying to manufacture in cheaper ways than the others

Sharing the cost of development makes a lot of sense because the
others *will* come up with their own linux drivers anyway if
it turns out to be money in selling hardware to linux users.
All loose by making separate drivers.

Also the cost of a GPL driver isn't merely shared - it could be
real low as you probably can get away with fewer developers.
You may be able to find someone who write a driver for free 
if given a few free cards and _good_ documentation.

Then there is the issue of maintenance costs.  They are high
for a closed linux driver, because Linus is not afraid of
making source-incompatible changes.  A driver in the
official source tree will usually be fixed for you - a
closed driver is _your_ problem with customers screaming
until they get a update.  Maybe they buy from another vendor
in the meantime.

If your boss don't buy any of this, consider tweaking the 
firmware to work with your card only, instead
of closing the driver.
 
> The other compromise is to write a closed source part that would not permit
> the driver to work with another card supporting the same chipset. Is this
> kind of practice generally accepted or is it frowned upon? The motive of the
> company is quite clear. If people want to "improve" the driver, they can
> only improve it for their hardware, not the competitors. There is also a big
> marketing sales pitch that goes like "we support linux, the others
> don&#8217;t..."

"Supporting linux" can be a lot more than "we provide drivers and the
others don't"

Consider:  This sales pitch will be used to sell to _linux users_.
So, it must match the mindset of linux people.

This:
"We provide GPL drivers for our cards (may or may not work with some
others)
and extensive docs and perhaps test cards for serious developers"

Sounds a hell of a lot better than:
"We provide a closed source driver for linux, artifically crippled so it
won't work with similiar cards from other manufacturers."

Clueful linux users will know that the first driver _will work_ with
any future kernel and bugs _will_ be fixed because everybody have
access to it.  And they will go for your card rather than the
competitor because of this.  The price difference for
hardware is probably small anyway and there could be ever so slight
incompatibilities with the non-supportive manufacturers card.
Performance will be high because volunteers don't merely fix
bugs, they also try out new cool algorithms and ideas.
And users know the card will be supported even after you stop
selling it.  That _is_ a selling point today.

They will also know that the second case driver _will_
lag behind kernel development by many months and bugs will take a long
time to fix - if ever.  Performance may not be as good as it could be.
Suddenly someone release a pc with a new bus trick that improves
performance, but your boss might not allocate 50 hours for implementing
that for "last years hardware".  

Is all linux users this clueful?  I don't know.  Probably those
who runs servers, and of course those who post recommendations
when the newbies ask "what hardware should I buy when setting
up a linux machine".  You _don't_ want to go into the FAQs as
ill-supported!


> It's like if Nvidia did not have linux drivers and ASUS wanted to ship a
> card with a linux driver that only works with asus cards even though there
> is one from leadtek with the exact same chipset (assuming that ASUS cannot
> change the internals of the card).
> 
> Is the second compromise just "going too far"? Is this better than simply
> having a 100% closed source driver?

Generally, the more open the better.  Keep in mind that buying
hw that needs a closed-source driver is something we do _only_ when
no competing product with a GPL driver exist.  Your competitors
might go the GPL way even if you don't.  Many users of closed drivers
do so because they converted a machine from windows to linux.
If they buy specifically for linux, they buy something well-supported.
And the ideal then is a driver in the official tree.  The second
best is a open source driver that might get into the tree - it just
hasn't happened yet.  A closed driver at least initiates a web search
for other harware...

Helge Hafting
