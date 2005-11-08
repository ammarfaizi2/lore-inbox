Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030298AbVKHStE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbVKHStE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 13:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030299AbVKHStD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 13:49:03 -0500
Received: from xenotime.net ([66.160.160.81]:12975 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030298AbVKHStA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 13:49:00 -0500
Date: Tue, 8 Nov 2005 10:48:56 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Alexey Dobriyan <adobriyan@gmail.com>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] DocBook: allow to mark structure members private
In-Reply-To: <20051108190048.GA12240@mipter.zuzino.mipt.ru>
Message-ID: <Pine.LNX.4.58.0511081048000.15288@shark.he.net>
References: <20051108183511.GA12043@mipter.zuzino.mipt.ru>
 <Pine.LNX.4.58.0511081025420.15288@shark.he.net> <20051108190048.GA12240@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Nov 2005, Alexey Dobriyan wrote:

> On Tue, Nov 08, 2005 at 10:27:01AM -0800, Randy.Dunlap wrote:
> > On Tue, 8 Nov 2005, Alexey Dobriyan wrote:
> > >  # /**
> > >  #  * struct my_struct - short description
> > >  #  * @a: first member
> > >  #  * @b: second member
> > > +#  * @c: nested struct
> > > +#  * @c.p: first member of nested struct
> > > +#  * @c.q: second member of nested struct
> > >  #  *
> > >  #  * Longer description
> > >  #  */
> > >  # struct my_struct {
> > >  #     int a;
> > >  #     int b;
> > > +#     struct her_struct {
> > > +#         char **p;
> > > +#         short q;
> > > +#     } c;
> > >  # };
> > >
> > > But properly nested displaying is in pretty much nil state since .. uh
> > > crap.. summer.
> >
> > Is this something that used to work?  If so, when?
>
> IIRC, I've done it to the state where it would print:
>
> 	int a;
> 	int b;
> 	char **c.p;
> 	short c.q;
>
> but that's not C.
>
> P. S.: Is htmldocs broken for someone else?
>
>   XMLTO  Documentation/DocBook/wanbook.html
> XPath error : Undefined variable
> compilation error: file file:///usr/share/sgml/docbook/xsl-stylesheets-1.66.1/xhtml/docbook.xsl
> line 114 element copy-of
> xsl:copy-of : could not compile select expression '$title'
> XPath error : Undefined variable
> $html.stylesheet != ''
>                  ^
> 		...

Is that after applying Martin's docbook patches yesterday?
(I haven't tested that yet.)

-- 
~Randy
