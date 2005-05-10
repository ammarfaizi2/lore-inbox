Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbVEJJjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbVEJJjw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 05:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVEJJjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 05:39:52 -0400
Received: from smtp.e7even.com ([83.151.192.5]:45501 "HELO smtp.e7even.com")
	by vger.kernel.org with SMTP id S261580AbVEJJj2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 05:39:28 -0400
Subject: Re: file as a directory
From: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
To: Hans Reiser <reiser@namesys.com>, sean.mcgrath@propylon.com
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
In-Reply-To: <1101287762.1267.41.camel@pear.st-and.ac.uk>
References: <2c59f00304112205546349e88e@mail.gmail.com>
	 <41A1FFFC.70507@hist.no> <41A21EAA.2090603@dbservice.com>
	 <41A23496.505@namesys.com>  <1101287762.1267.41.camel@pear.st-and.ac.uk>
Content-Type: text/plain
Message-Id: <1115717961.3711.56.camel@grape.st-and.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 May 2005 10:39:23 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Back in November 2004, I suggested on the linux-kernel and reiserfs
lists that the Reiser4 architecture could allow us to abolish the
unnatural naming distinction between directories/files/parts-of-file
(i.e. to unify naming within-file-system and within-file naming) in an
efficient way.
I suggested that one way of doing that would be to extend XPath-like
selection syntax above the (XML) file level.
(See the archive of the discussion starting at
http://www.ussg.iu.edu/hypermail/linux/kernel/0411.3/0044.html
Wed Nov 24 2004 - 04:21:13 EST.)

ITworld now has an interesting article by Sean McGrath on a very similar
idea, mentioning the XML OASIS Open Document Format. What do you think?

 Peter Foldiak

Here it is:

--

ITworld

http://www.itworld.com/AppDev/1246/nls_ebizbooks050510/

Books/chapters and directories/files - dichotomies considered harmful
ITworld.com, Ebusiness in the Enterprise 5/9/05

Sean McGrath, ITworld.com

The distinction between a full book and a mere chapter of a book, is a
source of endless fascination for incurable information modellers like
me.

Obviously, at the logical level, the distinction is driven by the
content itself. A book is a complete unit of stuff. A chapter, is a
sub-division within the complete book. At the physical level, however,
technology starts to influence the book/chapter distinction. A chapter
boundary, for Microsoft Word users or Open Office users, is likely to be
influenced by how big the underlying file gets. Large files take longer
to load and get increasingly slower to work with in typical word
processing environments. Our decisions about where to draw the chapter
boundaries are influenced to some extent by technology limitations.

If the physical constraints are not allowed to dictate the boundaries
for chapters, then we can end up resorting to file naming conventions to
split the content into manageable chunks e.g. chapter1_a, chapter1_b and
so on. We might then decide to keep things clean by introducing a
subdirectory for each chapter, putting the sub-chapters tidily away in
their own little compartments.

All is well with the world. Or is it? This is where things get
interesting from an information management perspective. A full unit of
work - a book - has now been split into bits that are navigable through
a directory structure and bits that are navigable through an
application. The result? You can use off-the-shelf tools to navigate
your way through the directories. You can see the overall structure of
the book by simply looking at the directory structure as a hierarchy.
You can see that chapter 1 has a number of sub-chapters. However, that
is as far as you can go. To dig any further into the structure of
chapter 1, section A, you need to launch the editing application.

What a pity.

Why is it, that we have this hard and fast dichotomy between directory
structure and file structure? Why is it that file system exploring
utilities need to stop in their tracks when they hit things called
'files'?

As you have probably noticed, this artificial split can be breached in
certain circumstances, at least to some extent. Graphics file formats
are a good example. Many file system exploring tools know about, say,
JPEG files and can display thumbnails of their contents.

That is a start in the right direction but I think it needs to go a lot
further if the artificial directory/file distinction is to be
eradicated.

Let us go back to the book example. Let us use Microsoft's OLE
technology as an analogy. With OLE you can embed one thing in another.
So for example, you can embed an Excel spreadsheet into a Word document
file. Now, in your head, take that further. Imagine a world in which the
file system explorer is the top level application. It manages a single,
humungous file on the disk into which you embed documents, spreadsheets,
databases etc. Each think you embed into the explorer can itself embed
other things to any depth required.

In such a world, directories/files have merged into one abstraction. The
book author does not have to introduce artificial segmentation of the
book into separate entities. In such a world, filenames become something
of an oddity. What do you need filenames for? You would only really need
a filename at the point where you decided to exchange information
between systems A and B.

Moreover, once the package of data is pasted into System B's file system
explorer at some suitable point, the filename would be thrown away.

Sounds interesting wouldn't you say? So why don't we have systems that
work like that? There are, as ever, many reasons. One reason which was
an issue some years ago, is ceasing to be an issue very quickly now.
Obviously, in order to show the structure of a "file" a file system
explorer needs to look inside the file format. If the file format is
proprietary, then we can do nothing.

Enter XML-based file formats like the OASIS Open Document Format[1]. The
day is coming when file system explorers will be able to do for office
documents, what they currently do for JPEGs. That is a start in the
right direction. Eventually, I hope we will see the directory/file
distinction begin to melt away.

Technologies/applications that never quite made it to the mainstream
such as OpenDoc[2] and FrameMaker[3] with its powerful Book/Chapter
model, may yet have a second coming.

[1] http://www.oasis-open.org/committees/office/charter.php
[2] http://www.webopedia.com/TERM/O/OpenDoc.html
[3] http://www.adobe.com/products/framemaker/main.html

Sean McGrath is CTO of Propylon. He is an internationally acknowledged
authority on XML and related standards. He served as an invited expert
to the W3C's Expert Group that defined XML in 1998. He is the author of
three books on markup languages published by Prentice Hall. Visit his
site at: http://seanmcgrath.blogspot.com.


