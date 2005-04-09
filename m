Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVDIHKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVDIHKF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 03:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVDIHKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 03:10:04 -0400
Received: from fire.osdl.org ([65.172.181.4]:63891 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261299AbVDIHJL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 03:09:11 -0400
Date: Sat, 9 Apr 2005 00:08:59 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Petr Baudis <pasky@ucw.cz>
Cc: torvalds@osdl.org, ross@jose.lug.udel.edu, linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM saga..
Message-Id: <20050409000859.73bf221f.rddunlap@osdl.org>
In-Reply-To: <20050409025357.GA9052@pasky.ji.cz>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
	<20050408041341.GA8720@taniwha.stupidest.org>
	<Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
	<20050408071720.GA23128@jose.lug.udel.edu>
	<Pine.LNX.4.58.0504080758420.28951@ppc970.osdl.org>
	<20050409025357.GA9052@pasky.ji.cz>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sat__9_Apr_2005_00_08_59_-0700_.9vUTXA2uV70s3Ff"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Sat__9_Apr_2005_00_08_59_-0700_.9vUTXA2uV70s3Ff
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 9 Apr 2005 04:53:57 +0200 Petr Baudis wrote:

|   Hello,
| 
| Dear diary, on Fri, Apr 08, 2005 at 05:50:21PM CEST, I got a letter
| where Linus Torvalds <torvalds@osdl.org> told me that...
| > 
| > 
| > On Fri, 8 Apr 2005 ross@jose.lug.udel.edu wrote:
| > > 
| > > Here's a partial solution.  It does depend on a modified version of
| > > cat-file that behaves like cat.  I found it easier to have cat-file
| > > just dump the object indicated on stdout.  Trivial patch for that is included.
| > 
| > Your trivial patch is trivially incorrect, though. First off, some files
| > may be binary (and definitely are - the "tree" type object contains
| > pathnames, and in order to avoid having to worry about special characters
| > they are NUL-terminated), and your modified "cat-file" breaks that.  
| > 
| > Secondly, it doesn't check or print the tag.
| 
|   FWIW, I made few small fixes (to prevent some trivial usage errors to
| cause cache corruption) and added scripts gitcommit.sh, gitadd.sh and
| gitlog.sh - heavily inspired by what already went through the mailing
| list. Everything is available at http://pasky.or.cz/~pasky/dev/git/
| (including .dircache, even though it isn't shown in the index), the
| cumulative patch can be found below. The scripts aim to provide some
| (obviously very interim) more high-level interface for git.
| 
|   I'm now working on tree-diff.c which will (surprise!) produce a diff
| of two trees (I'll finish it after I get some sleep, though), and then I
| will probably do some dwimmy gitdiff.sh wrapper for tree-diff and
| show-diff. At that point I might get my hand on some pull more kind to
| local changes.

Hi,

I'll look at your scripts this weekend.  I've also been
working on some, but mine are a bit more experimental (cruder)
than yours are.  Anyway, here they are (attached) -- also
available at http://developer.osdl.org/rddunlap/git/

gitin : checkin/commit
gitwhat sha1 : what is that sha1 file (type and contents if blob or commit)
gitlist (blob, commit, tree, or all) :
	list all objects with type (commit, tree, blob, or all)

---
~Randy

--Multipart=_Sat__9_Apr_2005_00_08_59_-0700_.9vUTXA2uV70s3Ff
Content-Type: application/octet-stream;
 name="gitin"
Content-Disposition: attachment;
 filename="gitin"
Content-Transfer-Encoding: base64

IyEgL2Jpbi9zaAojIGdpdGluOiBjaGVja2luIGZvciBnaXQgZmlsZXMKCiMgZ3JlcCBzaG93LWRp
ZmYgZm9yICsrKyA9PiBlcnJvciwgcHJpbnQgJ3J1biB1cGRhdGUtY2FjaGUgPGZpbGVuYW1lcz4n
LCBleGl0CiMJKGJldHRlciB3b3VsZCBiZSBhbiBlcnJvciBleGl0IGNvZGUpCiMgd3JpdGUtdHJl
ZSA+IGN1cnJlbnRfdHJlZV9vYmplY3QKIyBwcmludCAnZW50ZXIgY29tbWl0IG1lc3NhZ2U6Jwoj
IGNvbW1pdC10cmVlIGBjYXQgY3VycmVudF90cmVlX29iamVjdGAgLXAgYGNhdCAuZGlyY2FjaGUv
SEVBRGAgPiBjdXJyZW50X2NvbW1pdF9vYmplY3QKIyB1cGRhdGUgLmRpcmNhY2hlL0hFQUQgd2l0
aCBjdXJyZW50X2NvbW1pdF9vYmplY3QKCmRpZmZzPWBzaG93LWRpZmYgfCBncmVwICIrKysiYAoj
ZWNobyBkaWZmcz0vJGRpZmZzLwoKaWYgWyB4IiRkaWZmcyIgIT0geCBdOyB0aGVuCgllY2hvICJy
dW4gdXBkYXRlLWNhY2hlIDxmaWxlbmFtZXM+IgoJZXhpdApmaQoKdHJlZV9vYmplY3Q9YHdyaXRl
LXRyZWVgCiNlY2hvIHRyZWVfb2JqPS8kdHJlZV9vYmplY3QvCgpoZWFkPWBjYXQgLmRpcmNhY2hl
L0hFQURgCmVjaG8gImVudGVyIGNvbW1pdCBtZXNzYWdlOiAoZW5kIHdpdGggXkQpIgpjb21taXRf
b2JqZWN0PWBjb21taXQtdHJlZSAkdHJlZV9vYmplY3QgLXAgJGhlYWRgCiNlY2hvIGNvbW1pdF9v
Ymo9LyRjb21taXRfb2JqZWN0LwoKZWNobyAkY29tbWl0X29iamVjdCA+IC5kaXJjYWNoZS9IRUFE
Cg==

--Multipart=_Sat__9_Apr_2005_00_08_59_-0700_.9vUTXA2uV70s3Ff
Content-Type: application/octet-stream;
 name="gitlist"
Content-Disposition: attachment;
 filename="gitlist"
Content-Transfer-Encoding: base64

IyEgL2Jpbi9zaAojIGdpdGxpc3Q6IGxpc3Qgc29tZSBnaXQgb2JqZWN0cy90eXBlcwojIChieSBz
ZWxlY3RlZCB0YXJnZXQgdHlwZTogYmxvYiwgdHJlZSwgY29tbWl0LCBhbGwpCgp0YXJnZXQ9JDEK
aWYgWyAteiAiJHRhcmdldCIgXTsgdGhlbgoJZWNobyAidXNhZ2U6IGdpdGxpc3QgdHlwZSB7Ymxv
YiwgdHJlZSwgY29tbWl0LCBvciBhbGx9IgoJZXhpdCAxCmZpCgoKc3ViZGlyPS5kaXJjYWNoZS9v
YmplY3RzLwoKZm9yIGhpZ2ggaW4gMCAxIDIgMyA0IDUgNiA3IDggOSBhIGIgYyBkIGUgZiA7IGRv
CiAgICBmb3IgbG93IGluIDAgMSAyIDMgNCA1IDYgNyA4IDkgYSBiIGMgZCBlIGYgOyBkbwoJdG9w
PSRoaWdoJGxvdwoKCWZvciBmIGluICRzdWJkaXIvJHRvcC8qIDsgZG8KCQlpZiBbICEgLXIgJGYg
XTsgdGhlbgoJCQljb250aW51ZQoJCWZpCgkJYmFzZT1gYmFzZW5hbWUgJGZgCgkJdHlwZT1gY2F0
LWZpbGUgLXQgJHRvcCRiYXNlYAoJCWlmIFsgJHRhcmdldCA9PSAiYWxsIiAtbyAkdGFyZ2V0ID09
ICR0eXBlIF07IHRoZW4KCQkJZWNobyAkdG9wJGJhc2UgOiAkdHlwZSAKCQlmaQoJZG9uZQogICAg
ZG9uZQpkb25lCg==

--Multipart=_Sat__9_Apr_2005_00_08_59_-0700_.9vUTXA2uV70s3Ff
Content-Type: application/octet-stream;
 name="gitwhat"
Content-Disposition: attachment;
 filename="gitwhat"
Content-Transfer-Encoding: base64

IyEgL2Jpbi9zaAojIGdpdHdoYXQ6IHdoYXQgaXMgdGhhdCBmaWxlCgpzaGExPSQxCmlmIFsgLXog
JHNoYTEgXTsgdGhlbgoJZWNobyAidXNhZ2U6IGdpdHdoYXQgc2hhMSIKCWV4aXQgMQpmaQoKd2hh
dD1gY2F0LWZpbGUgLXQgJHNoYTFgCmlmIFsgLXogIiR3aGF0IiBdOyB0aGVuCglleGl0IDEKZmkK
ZWNobyAidHlwZSBpczogJHdoYXQiCgp0b3BkaXI9JHtzaGExOjA6Mn0KbGFzdD0ke3NoYTE6Mn0K
ZmlsZT0uZGlyY2FjaGUvb2JqZWN0cy8kdG9wZGlyLyRsYXN0CgppZiBbIC16ICRQQUdFUiBdOyB0
aGVuCglwYWdlcj1tb3JlCmVsc2UKCXBhZ2VyPSRQQUdFUgpmaQoKY2FzZSAkd2hhdCBpbgpibG9i
KQoJI2hlYWQgLTEwICRmaWxlCgkjJHBhZ2VyICRmaWxlCgljYXQtZmlsZSBibG9iICRzaGExIHwg
JHBhZ2VyCgk7Owp0cmVlKQoJZWNobyAiY2Fubm90IHByaW50IGJpbmFyeSB0cmVlIgoJI2NhdC1m
aWxlIHRyZWUgJHNoYTEgfCAkcGFnZXIKCTs7CmNvbW1pdCkKCWNhdC1maWxlIGNvbW1pdCAkc2hh
MSB8ICRwYWdlcgoJOzsKZXNhYwo=

--Multipart=_Sat__9_Apr_2005_00_08_59_-0700_.9vUTXA2uV70s3Ff--
