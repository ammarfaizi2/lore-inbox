Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268080AbUH2Qdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268080AbUH2Qdo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 12:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268085AbUH2Qdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 12:33:44 -0400
Received: from smcc.demon.nl ([212.238.157.128]:17939 "HELO smcc.demon.nl")
	by vger.kernel.org with SMTP id S268080AbUH2Qdj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 12:33:39 -0400
From: "Nemosoft Unv." <nemosoft@smcc.demon.nl>
Organization: I'm not organized
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pwc+pwcx is not illegal
Date: Sun, 29 Aug 2004 18:33:37 +0200
User-Agent: KMail/1.6.1
Cc: Linus Torvalds <torvalds@osdl.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pmarques@grupopie.com, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net
References: <1093634283.431.6370.camel@cube> <Pine.LNX.4.58.0408271226400.14196@ppc970.osdl.org> <1093788018.27901.35.camel@localhost.localdomain>
In-Reply-To: <1093788018.27901.35.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200408291833.37808@smcc.demon.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sunday 29 August 2004 16:00, Alan Cox wrote:
> On Gwe, 2004-08-27 at 20:29, Linus Torvalds wrote:
> > So stop whining about it. The driver got removed because the author
> > asked for it.
>
> Please put it back, minus the hooks so the rest of the world can use it.

No, don't! There is one very practial reason for that: the utter confusion 
it will cause when suddenly PWCX cannot be loaded anymore, because users 
will assume that since PWC is in the kernel, PWCX will work too. I really 
would not like to be at the receiving end of the support mailbox when 2.6.9 
comes out with such a crippled version of PWC.

That's one of the reasons I requested PWC to be removed. For me, it's also a 
matter of quality: what good is a half-baked driver in the kernel when you 
need to patch it first to get it working fully again? I don't want my name 
attached to that.

> If not please remove every line of code I've even written because I
> don't like the new attitude .. so ner..
>
> Point made ? We can't go around throwing out drivers because the author
> had a tantrum. 

I'm not having a tantrum. If it is, it has been one in the making for 3 
years.

> Its also trivial to move the decompressor to user space 
> where it should be anyway. 

*sigh* As I have been saying a 100 times before, it is illogical, cumbersome 
for both users and developers, and will probably take a very long time to 
adopt (notwithstanding V4L2 [*]). 

I mean, I still remember when the YUV->RGB conversion code was snipped from 
PWC when I supplied it for inclusing in the kernel, back in 2001. It took a 
long, long time for webcam tools to adjust their code to check for the YUV 
palette and do the conversion themselves, and _to_this_very_day_ I'm 
getting mails about programs who still don't get it right.

*IF* there was a commonly accepted video "middle-layer", this would not pose 
much of a problem. But there is no such thing yet.

(maybe that's something for a 2.7 kernel...)

> Similarly the driver is useful without the binary stuff.

True. But judging from the mails I have received the last couple of days,
people don't really care about the binary stuff, as long as it works. They 
want to use the cam to its full potential, so PWCX is more or less a 
necessity. However, there's has now been added an extra hurdle in getting 
it work, for reasons I find questionable, and really, 3 years too late.

Seriously, this probably would not have happened if, back in 2001, the 
driver was rejected on the basis of this hook (you were there, Alan...) I 
never made a secret of it, it has been in the driver from day 1 and its 
purpose was clearly spelled out. If it had been rejected, I would probably 
have just switched to '3rd party module' mode and maintained it outside the 
kernel indefinetely. I would not have liked it, but it would have been 
acceptable.

Another acceptable solution would have been, if after the 'discovery' of the 
hook, Greg or anybody else had said: "Look, we really don't want this kind 
of thing in the kernel. However, since we're a bit late to react, we'll 
leave it in the 2.4 and 2.6 series, but versions beyond that (2.7-devel, 
etc) will not have PWC included in this form. In the mean time, we're 
asking you to think of a solution". Chances are the situation would have 
been fully resolved before that (and I mean fully *hint*).

> Or do we need a -ac tree again where this time -ac is "added camera" ;)

*lol* The code is still floating around on the Net, so nobody's stopping 
you... 

 - Nemosoft


[*] Some advice: if you really want to speed up V4L2 adoption by video 
tools, start disabling V4L1 in the kernel... 

