Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267357AbTAMN0Z>; Mon, 13 Jan 2003 08:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267362AbTAMN0Z>; Mon, 13 Jan 2003 08:26:25 -0500
Received: from tomts7.bellnexxia.net ([209.226.175.40]:985 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S267357AbTAMN0X>; Mon, 13 Jan 2003 08:26:23 -0500
Date: Mon, 13 Jan 2003 08:26:44 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: why the new config process is a *big* step backwards
Message-ID: <Pine.LNX.4.44.0301130743100.25468-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  (apologies to those who are thoroughly sick of this topic, but
i'm now firmly convinced that i don't much care for the new
config process, and i'm curious as to whether it's just me.
Answer: probably.)

  IMHO, the new config process (and i'll restrict myself to talking
about the graphical "make xconfig" process here) not only doesn't
improve substantially over the old one, but is actually worse in 
a number of places.  where to start?

  first, the hierarchical structure of the options in the left
window (i'm going to make up names and call these the "menu window",
"option window" and "help window") is non-intuitive, in that the
top-level selection will bring up a set of selectable options,
while submenus will *also* bring up options.

  example:  Power management options.  if i select that menu
option explicitly, i get options including APM in the option
window.  but if i expand that option, i can select the submenu
"ACPI Support", for further options.  this is confusing --
it's analogous to a directory having files both directly inside
it *and* within a sub-structure.  

  this is inconsistent with other common things people are
familiar with -- in the pine mailer, for example, you can't
use a folder both for storing files *and* for having subfolders.
and think about bookmarks in a browser (a model i wish the new
config process had followed).

  the current design is messy since it suggests that some
options belong strictly to the top level, while others belong
to more specialized sub levels.  if that's the case, then
the menu window should contain something like:

[+] Power management options (APM, ACPI)
      Basic APM options
      ACPI Support

(obviously, this would apply to *all* entries in the menu
window thave have submenus.)

  but wait, you say, there's an advantage to this approach.
it means i can, with one click, get to the more common settable
options, rather than needing to expand the top level menu.
so we get to my second complaint.

  there's no reason to not have checkboxes *right* *in*
the menu window, so i can see *immediately* whether i have
entire submenu options selected.

  consider "IrDA (infrared) support".  from the menu window,
there's no way to tell if i have this selected.  instead, i
must select that option, get it's option window displayed, and
only then can i see/select/deselect *all* of IrDA in one fell
swoop.  (of course, the same is true of submenus where, e.g.,
under Networking support, i can only deselect all of 
"Ethernet 1000 Mbit" by first selecting that option, getting
its menu, then turning it off at the top.)
 
  this is hideously uninformative, since it's impossible to tell
at a glance what entire submenus are selected or not.  why
*shouldn't* i be able to see, with one look, that my current
configuration is not selecting Plug and Play, SCSI, Amateur
Radio, IrDA, IDSN, Power Management and Bluetooth?  adding
selection checkboxes to top-level entries in the menu window
would make this trivial, and it's one area that the previous
configuration program fell down as well.  it's disappointing
that this was not addressed.

  my third complaint represents where the new config process is
actually *worse* than the previous.  the fact that there is
a single menu window and a single option window makes it
impossible to work in detail in more than one part of the
main menu at a time (assuming i haven't overlooked some neat
feature of this new process).

  at least in the old "make xconfig", i could bring up two
children dialogs at a time.  perhaps i want to examine/configure
both "Block devices" and "Filesystems" at the same time, since
there are some related features (loopback device support under
Block devices lets me mount filesystem images).  under the
new scheme, this is impossible (unless there's a trick or
feature i haven't found).

  and that option window is just confusing.  given that we
already have +/- expand/collapse icons, and checkboxes for
selection, it just makes things messier to have these submenu
boxes with the internal triangle.  and once it takes you to
that submenu, is it really painfully obvious how you back up
one level?  (the arrow icon in the tool bar?)

  frankly, i would like to see the option window disappear
entirely.  i see no need to have more than two frames --
a menu window with expandable/collapsible choices, where
i can select/deselect entire chunks with a click, where it's
obvious at a glance which parts are deselected, and where
i can expand more than one part of the top-level menu to
configure more than one set of options at a time.

  (this would be even more practical if the number of top-level
entries in the menu window was reduced.  i mean, is it really
necessary to have separate top-level entries for MTD, Fusion
MPT and related selections?  why not just a top-level entry
for some kind of all-encompassing "Device support"?  i know,
that's a bad name, but you get the idea.)

  anyway, i've rambled enough.  time for coffee.

rday

