Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265172AbTLaPZj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 10:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265175AbTLaPZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 10:25:39 -0500
Received: from imap.infonegocio.com ([213.4.129.150]:45787 "EHLO
	telesmtp3.mail.isp") by vger.kernel.org with ESMTP id S265172AbTLaPZX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 10:25:23 -0500
From: Xan <DXpublica@telefonica.net>
Reply-To: DXpublica@telefonica.net
To: Matthias Schniedermeyer <ms@citd.de>
Subject: Re: i18n for kernel 2.7.x?
Date: Wed, 31 Dec 2003 16:25:24 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200312311332.15422.DXpublica@telefonica.net> <20031231125156.GA12588@citd.de>
In-Reply-To: <20031231125156.GA12588@citd.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312311625.25178.DXpublica@telefonica.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dimecres 31 Desembre 2003 13:51, en/na Matthias Schniedermeyer (<Matthias 
Schniedermeyer <ms@citd.de>>) va escriure:

> On Wed, Dec 31, 2003 at 01:32:15PM +0100, Xan wrote:
> > Hi,
> >
> > Just a thing: why not internationalization of kernel. That is, why not
> > that the kernel could display error or debug messages in different
> > languages (for example)?
>
> This is a FAQ.
>
> http://www.kernel.org/pub/linux/docs/lkml/#s9-16
>
> So it should be better to end this before it begins (again).

It appears that you (kernel developers) have panic about it. Wow!. What a 
contundent message!. It appears as a tabu topic.

In the link you provide me, there is the following information, but I want to 
point some comments about it:

** (REG) There are several reasons why this should not be done: 
**	- It would bloat the kernel sources 

Yes it bloat the kernel sources. It's evident as the support of new driver 
will bloat. It's a redesign of a kernel in more abstract way and the majorty 
of all abstraction redesign do.

I think that the key is what we will win and what we will lose with i18n of 
kernel. I believe that the positive reasons have more weight.

Why not make a module that displays all the information from the kernel to the 
user, shell, ....?. It not only serve us for i18n. It could serve us as low 
support for Brailley's readers or any other outputs. Imagine that the kernel 
is running in a virtually reality machine. It could be interesting that if a 
kernel bug appears in some process, then the bug is displayed as sound, image 
and feelings (the next virtually reallity machine gerneration will support 
this). So there is a little work of kernel in this process of displaying 
bugs. isn't?

**	- It would drastically increase the cost of maintaining the kernel message 
database 

Not. We could have all the traductions as avaliable modules. If we want 
display message in catalan, so we have to "load" the cataln module and switch 
to catalan the display option of kernel. The database of messages?. If we 
have the english messages in the core kernel (eventually with an identifier), 
then, in some circumstances, the core kernel pass this message to module of 
display, say M, then M with the help of cataln module translate literally the 
english message in catalan message. I believe that M can add to the 
traduction some process as: "show it as brailley" if module is avaliable.

	- Kernel message output would slow down 
** We will have to think what optimize the message output with the new 
situation. I beleive that it's more prefered the abstraction versus a little 
bit more slowly kernel.

**	- English is the language in which the kernel sources are written, and thus 
is the language in which kernel messages are written. Developers cannot be 
expected to provide translations 

Yes, but the developers allways have the original message. We could add an id 
to any message. So any "translated bug" that we send to any developer has its 
id and so the devenloper could see the message in the id-message table.

And it's clear that the developers will not translate nothing. Sure there will 
be other people that would translate mesages.

***	- Bug reports should be submitted in English, and that includes kernel 
messages. If kernel messages were to be output in some other language, most 
developers could not help in fixing bugs 


***	- Translation can be performed in user-space, there is no need to change 
the kernel 

---> How?

	- It would bloat the kernel sources 
Finally, it will not be done. No core developer supports this. Neither does 
Linus. Don't even ask. 

And the internationalization of the Documentation directory, README,... files 
and the web page?

Regards,
Xan.
>
>
>
> Bis denn

