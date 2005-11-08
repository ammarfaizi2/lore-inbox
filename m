Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030295AbVKHSrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030295AbVKHSrq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 13:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbVKHSrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 13:47:46 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:57281 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030295AbVKHSr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 13:47:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Kv1OeIGnAlU/LN7YsEX8n2IwjE4osAJSr7NrAmHh3Cq3WSu98iqwQVZ42gXRZFAcYW3C+G5/msdqXiXjRnqjk7SBvyI78Y530YRZAOa+qtHw7HKc+qTvg35f3sX+32yBoaXWsGvw5TQCDyu8zTzBAPwpsVaCTcddNL93WEyn0t0=
Date: Tue, 8 Nov 2005 22:00:48 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] DocBook: allow to mark structure members private
Message-ID: <20051108190048.GA12240@mipter.zuzino.mipt.ru>
References: <20051108183511.GA12043@mipter.zuzino.mipt.ru> <Pine.LNX.4.58.0511081025420.15288@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0511081025420.15288@shark.he.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 10:27:01AM -0800, Randy.Dunlap wrote:
> On Tue, 8 Nov 2005, Alexey Dobriyan wrote:
> >  # /**
> >  #  * struct my_struct - short description
> >  #  * @a: first member
> >  #  * @b: second member
> > +#  * @c: nested struct
> > +#  * @c.p: first member of nested struct
> > +#  * @c.q: second member of nested struct
> >  #  *
> >  #  * Longer description
> >  #  */
> >  # struct my_struct {
> >  #     int a;
> >  #     int b;
> > +#     struct her_struct {
> > +#         char **p;
> > +#         short q;
> > +#     } c;
> >  # };
> >
> > But properly nested displaying is in pretty much nil state since .. uh
> > crap.. summer.
>
> Is this something that used to work?  If so, when?

IIRC, I've done it to the state where it would print:

	int a;
	int b;
	char **c.p;
	short c.q;

but that's not C.

P. S.: Is htmldocs broken for someone else?

  XMLTO  Documentation/DocBook/wanbook.html
XPath error : Undefined variable
compilation error: file file:///usr/share/sgml/docbook/xsl-stylesheets-1.66.1/xhtml/docbook.xsl
line 114 element copy-of
xsl:copy-of : could not compile select expression '$title'
XPath error : Undefined variable
$html.stylesheet != ''
                 ^
		...

