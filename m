Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262375AbVAUObB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbVAUObB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 09:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbVAUObB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 09:31:01 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:46478 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262376AbVAUOaY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 09:30:24 -0500
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Fri,_21_Jan_2005_14_30_12_+0000_0@merlin.emma.line.org>
Content-Type: text/plain; charset=US-ASCII
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 7BIT
Message-Id: <20050121143012.96BA678179@merlin.emma.line.org>
Date: Fri, 21 Jan 2005 15:30:12 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.265, 2005-01-21 15:29:37+01:00, matthias.andree@gmx.de
  Make "Info: these address mappings could be added after clean-up:" messages
  non-default. Add a new --warnverbose option to select these messages.
  Suggested by Vitezslav Samel.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
 shortlog |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

##### GNUPATCH #####
--- 1.233/shortlog	2005-01-20 14:11:22 +01:00
+++ 1.234/shortlog	2005-01-21 15:29:37 +01:00
@@ -3375,7 +3375,7 @@
 my @opts = ("help|?|h", "man", "mode=s", "compress!", "count!", "width:i",
 	    "swap!", "merge!", "warn!", "multi!", "abbreviate-names!",
 	    "by-surname!", "selftest", "ignoremerge!", "omitaddresses!",
-	    "obfuscate!");
+	    "obfuscate!", "warnverbose!");
 #	    "bitkeeper|bk!");
 
 # How do we parse them?
@@ -3533,7 +3533,7 @@
       }
     }
   }
-  if (scalar keys %address_found_in_from) {
+  if ($opt{warnverbose} and scalar keys %address_found_in_from) {
     print STDERR "Info: these address mappings could be added after clean-up:\n";
     foreach (sort caseicmp keys %address_found_in_from) {
       print STDERR $address_found_in_from{$_}, "\n" or write_error();
@@ -3570,6 +3570,10 @@
                      and suppress the prolog
      --[no]multi     states that multiple changelogs are in one file
      --[no]warn      warn about unknown addresses. Default: set!
+     --[no]warnverbose
+                     suggest more addresses to be added from
+                     Signed-off-by and From lines. Default: unset.
+                     Use with caution!
      --[no]abbreviate-names
                      abbreviate all but the last name
      --[no]by-surname



##### BKPATCH #####

## Wrapped with gzip_b64 ##
H4sIAPQR8UECA+1Va0/bMBT9XP+KS9mkIZY0dprn1IlH90BsGqJiX6YJuclNGzWxq9ihMLr/
PofQFhCTxsbHOZESO9fn3nvOUbwNR8O4o2V1wYtU7c1RTOpc2LriQpWouZ3Icnk45WKCI9RL
5jjMXJS5ju9FSxb5nrdEhp6X9CkfB2GACSPbcKawijsl13qac2VzkVaIZv2jVDruTMpLO22m
p1KaaU/VCnszrAQWvYNjc1vtxNJSFoqYwBOukylcYKXiDrXd9Yq+mmPcOX334ezT/ikhgwGs
a4XBgDxzXw/62Wv7uA/jGRCHupQytvQ9GjEyBGoz3wPH6zm0xyhQL2ZR7Aa7Do0dBx5HhV0K
lkMO4Jl7OCQJfOYzhO6RyGQMeooKgacmtVKmlvk8FxMFiayLFMY3XzAFnmmsICmQC6uex10o
TTSfoDJoQgorxYzXhbZhPzXBIHABlrXglTCSjaVJIOc6l8I0AwoLTPRt3hWMbXBG9cS8aZNt
fAVfc40/VMEvYMRLLGxyDL7HHJecbBQm1hMHIQ53yNsNpVNZ4gM+1VRWupCTlk6Phk7QD2i4
dGkQecsMI54lgRNxB1M+Tn8j3j2UxhGU9lnkBkuPBsy78ekq4p5N/7ke8of1rBzq9sPQbR3q
9p/sUB8s9t+hG4e26n4Bq1pcNrd1aey6ov4v3Dp03SAESo5unx0woyvHWa0SrnGr+xq6d1rY
6u68MXs817/Z0z4B8gxevTDdXd8J/QlGSjAoBa9ghlcKXt4SfJ7JWqTnuTjPKlnuwHWDFDDo
kya54eybkN/vILXLD4dqmYJSVmvpUDXkrgVr4B/fPMonAlNLZplleG4KfW9iociFkQGGrZAx
1EKhth+HMOcPLHI9hYTXjaxbm0MkmWIyU3U58EOaYmh+CL8AI2D67wQHAAA=

