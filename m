Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966430AbWKYMV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966430AbWKYMV5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 07:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966437AbWKYMV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 07:21:57 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:17086 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S966430AbWKYMV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 07:21:56 -0500
X-Originating-Ip: 72.57.81.197
Date: Sat, 25 Nov 2006 07:17:46 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: making entire driver submenus selectable
Message-ID: <Pine.LNX.4.64.0611250700480.21208@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-533944259-1164457066=:21208"
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	timed out)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-533944259-1164457066=:21208
Content-Type: TEXT/PLAIN; charset=US-ASCII


part 1:

  by way of intro, note how under "General setup", the last entry:

     [ ] Configure standard kernel features (for small systems)  --->

visually represents a sub-menu and *ostensibly* shows whether any of
those sub-menu choices will be selectable based on that top-level
selection.

  why can't this be applied more often, particularly under the
"Device Drivers" menu?  there are numerous categories under that menu
where you have to *go* to that submenu just to see that that option
has been deselected in its entirety.  why not use the same technique
as above and make those driver submenus selectable?

  as an example, i've attached a trivial patch that does this for MTD
support.  personally, i'd love to see a Drivers menu in which i could
*immediately* see which sub-categories are entirely deselected without
having to go into each one one at a time, and the kind of patch i've
attached for MTD would seem to allow just that.  (other submenus where
this would make sense would be things like Fusion MPT, ISDN, Telephony
... the list goes on and on.)

  (an even better approach would be to have the "--->" submenu visual
disappear if you deselect that option, but i'm not greedy -- i'll take
what i can get.  :-)

  thoughts?  and, yes, i can submit patches. :-)

part 2:

  returning to that top-level "General setup" menu, if i see something
like this:

    [ ] Configure standard kernel features (for small systems)  --->

and i don't know any better, i would have assumed that deselecting
that top-level entry would subsequently deselect all sub-menu entries.
but that's not what happens.

  even without selecting that top-level config option, one of the
sub-menu entries:

    [*]     Include all symbols in kallsyms

is still selected.  in fact, that option doesn't even depend on the
sub-menu that it's a part of.  i think that's extremely misleading --
i think that menu entries should all explicitly depend on the sub-menu
that they're a part of, to avoid potential confusion.

  thoughts on that too?

rday
--8323328-533944259-1164457066=:21208
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=mtd.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0611250717460.21208@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename=mtd.patch

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL0tjb25maWcgYi9kcml2ZXJzL210
ZC9LY29uZmlnDQppbmRleCBhMzA0YjM0Li5hMGM5ZjEzIDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9tdGQvS2NvbmZpZw0KKysrIGIvZHJpdmVycy9tdGQvS2Nv
bmZpZw0KQEAgLTEsOCArMSw2IEBADQogIyAkSWQ6IEtjb25maWcsdiAxLjEx
IDIwMDUvMTEvMDcgMTE6MTQ6MTkgZ2xlaXhuZXIgRXhwICQNCiANCi1tZW51
ICJNZW1vcnkgVGVjaG5vbG9neSBEZXZpY2VzIChNVEQpIg0KLQ0KLWNvbmZp
ZyBNVEQNCittZW51Y29uZmlnIE1URA0KIAl0cmlzdGF0ZSAiTWVtb3J5IFRl
Y2hub2xvZ3kgRGV2aWNlIChNVEQpIHN1cHBvcnQiDQogCWhlbHANCiAJICBN
ZW1vcnkgVGVjaG5vbG9neSBEZXZpY2VzIGFyZSBmbGFzaCwgUkFNIGFuZCBz
aW1pbGFyIGNoaXBzLCBvZnRlbg0KQEAgLTI4MCw2ICsyNzgsMyBAQCBzb3Vy
Y2UgImRyaXZlcnMvbXRkL2RldmljZXMvS2NvbmZpZyINCiBzb3VyY2UgImRy
aXZlcnMvbXRkL25hbmQvS2NvbmZpZyINCiANCiBzb3VyY2UgImRyaXZlcnMv
bXRkL29uZW5hbmQvS2NvbmZpZyINCi0NCi1lbmRtZW51DQotDQo=

--8323328-533944259-1164457066=:21208--
