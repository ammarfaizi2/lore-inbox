Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312446AbSDCWhK>; Wed, 3 Apr 2002 17:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312444AbSDCWhC>; Wed, 3 Apr 2002 17:37:02 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:1734 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S312443AbSDCWgm>; Wed, 3 Apr 2002 17:36:42 -0500
Date: Wed, 3 Apr 2002 17:36:34 -0500 (EST)
From: "Mike A. Harris" <mharris@redhat.com>
X-X-Sender: mharris@devserv.devel.redhat.com
To: marcelo@conectiva.com.br
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Process Accounting 32bit UID/GID support
Message-ID: <Pine.LNX.4.44.0204031734030.21723-200000@devserv.devel.redhat.com>
Organization: Red Hat Inc.
X-Unexpected-Header: The Spanish Inquisition
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="279707962-865861748-1017847275=:21723"
Content-ID: <Pine.LNX.4.44.0204031734040.21723@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--279707962-865861748-1017847275=:21723
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44.0204031734041.21723@devserv.devel.redhat.com>

(Apologies to anyone getting this as a dupe, my first mail 
 bounced)

After receiving a handful of bug reports about process accounting
not working properly with 32bit UID/GID's, and investigating the
problem, I discovered the reason was that it just was not 
implemented yet.  After briefly discussing this with Alan and 
Arjan, I've created support for this feature, while maintaining 
full binary backward compatibility with existing tools.

I've also hacked the userland acct package (psacct in Red Hat
Linux) to support the new feature as well, while also remaining
backward compatible with kernels that do not have the new 32bit 
UID/GID patch.

Marcelo, could you add this to the 2.4.x queue?

TIA

-- 
Mike A. Harris                  Shipping/mailing address:
OS Systems Engineer             190 Pittsburgh Ave., Sault Ste. Marie,
XFree86 maintainer              Ontario, Canada, P6C 5B3
Red Hat Inc.
http://www.redhat.com           ftp://people.redhat.com/mharris

--279707962-865861748-1017847275=:21723
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="kernel-2.4.18-acct-32bit-uid-gid.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0204031021150.21723@devserv.devel.redhat.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="kernel-2.4.18-acct-32bit-uid-gid.patch"

LS0tIC4va2VybmVsL2FjY3QuYy5wc2FjY3QtMzJiaXQtdWlkLWdpZAlNb24g
QXByICAxIDEyOjQzOjMzIDIwMDINCisrKyAuL2tlcm5lbC9hY2N0LmMJV2Vk
IEFwciAgMyAxMDoxNzo0MyAyMDAyDQpAQCAtOCw2ICs4LDkgQEANCiAgKiAg
U29tZSBjb2RlIGJhc2VkIG9uIGlkZWFzIGFuZCBjb2RlIGZyb206DQogICog
IFRob21hcyBLLiBEeWFzIDx0ZHlhc0BlZGVuLnJ1dGdlcnMuZWR1Pg0KICAq
DQorICogIEFwcmlsIDIsIDIwMDIgLSBNaWtlIEEuIEhhcnJpcyA8bWhhcnJp
c0ByZWRoYXQuY29tPg0KKyAqICAtIGFkZGVkIDMyYml0IFVJRC9HSUQgc3Vw
cG9ydA0KKyAqDQogICogIFRoaXMgZmlsZSBpbXBsZW1lbnRzIEJTRC1zdHls
ZSBwcm9jZXNzIGFjY291bnRpbmcuIFdoZW5ldmVyIGFueQ0KICAqICBwcm9j
ZXNzIGV4aXRzLCBhbiBhY2NvdW50aW5nIHJlY29yZCBvZiB0eXBlICJzdHJ1
Y3QgYWNjdCIgaXMNCiAgKiAgd3JpdHRlbiB0byB0aGUgZmlsZSBzcGVjaWZp
ZWQgd2l0aCB0aGUgYWNjdCgpIHN5c3RlbSBjYWxsLiBJdCBpcw0KQEAgLTI5
OCw4ICszMDEsMTAgQEANCiAJYWMuYWNfZXRpbWUgPSBlbmNvZGVfY29tcF90
KGppZmZpZXMgLSBjdXJyZW50LT5zdGFydF90aW1lKTsNCiAJYWMuYWNfdXRp
bWUgPSBlbmNvZGVfY29tcF90KGN1cnJlbnQtPnRpbWVzLnRtc191dGltZSk7
DQogCWFjLmFjX3N0aW1lID0gZW5jb2RlX2NvbXBfdChjdXJyZW50LT50aW1l
cy50bXNfc3RpbWUpOw0KLQlhYy5hY191aWQgPSBjdXJyZW50LT51aWQ7DQot
CWFjLmFjX2dpZCA9IGN1cnJlbnQtPmdpZDsNCisJYWMuYWNfdWlkID0gaGln
aDJsb3d1aWQoY3VycmVudC0+dWlkKTsNCisJYWMuYWNfZ2lkID0gaGlnaDJs
b3dnaWQoY3VycmVudC0+Z2lkKTsNCisJYWMuYWNfdWlkMzIgPSBjdXJyZW50
LT51aWQ7DQorCWFjLmFjX2dpZDMyID0gY3VycmVudC0+Z2lkOw0KIAlhYy5h
Y190dHkgPSAoY3VycmVudC0+dHR5KSA/IGtkZXZfdF90b19ucihjdXJyZW50
LT50dHktPmRldmljZSkgOiAwOw0KIA0KIAlhYy5hY19mbGFnID0gMDsNCi0t
LSAuL2luY2x1ZGUvbGludXgvYWNjdC5oLnBzYWNjdC0zMmJpdC11aWQtZ2lk
CU1vbiBBcHIgIDEgMTI6Mzk6MjggMjAwMg0KKysrIC4vaW5jbHVkZS9saW51
eC9hY2N0LmgJV2VkIEFwciAgMyAxMDoxODo0MCAyMDAyDQpAQCAtMyw2ICsz
LDkgQEANCiAgKg0KICAqICBBdXRob3I6IE1hcmNvIHZhbiBXaWVyaW5nZW4g
KG12d0BwbGFuZXRzLmVsbS5uZXQpDQogICoNCisgKg0KKyAqICBBcHJpbCAy
LCAyMDAyIC0gTWlrZSBBLiBIYXJyaXMgPG1oYXJyaXNAcmVkaGF0LmNvbT4N
CisgKiAgLSBhZGRlZCAzMmJpdCBVSUQvR0lEIHN1cHBvcnQNCiAgKiAgVGhp
cyBoZWFkZXIgZmlsZSBjb250YWlucyB0aGUgZGVmaW5pdGlvbnMgbmVlZGVk
IHRvIGltcGxlbWVudA0KICAqICBCU0Qtc3R5bGUgcHJvY2VzcyBhY2NvdW50
aW5nLiBUaGUga2VybmVsIGFjY291bnRpbmcgY29kZSBhbmQgYWxsDQogICog
IHVzZXItbGV2ZWwgcHJvZ3JhbXMgdGhhdCB0cnkgdG8gZG8gc29tZXRoaW5n
IHVzZWZ1bCB3aXRoIHRoZQ0KQEAgLTU2LDcgKzU5LDkgQEANCiAJY29tcF90
CQlhY19zd2FwczsJCS8qIEFjY291bnRpbmcgTnVtYmVyIG9mIFN3YXBzICov
DQogCV9fdTMyCQlhY19leGl0Y29kZTsJCS8qIEFjY291bnRpbmcgRXhpdGNv
ZGUgKi8NCiAJY2hhcgkJYWNfY29tbVtBQ0NUX0NPTU0gKyAxXTsJLyogQWNj
b3VudGluZyBDb21tYW5kIE5hbWUgKi8NCi0JY2hhcgkJYWNfcGFkWzEwXTsJ
CS8qIEFjY291bnRpbmcgUGFkZGluZyBCeXRlcyAqLw0KKwlfX3UzMgkJYWNf
dWlkMzI7CQkvKiBBY2NvdW50aW5nIFJlYWwgMzJiaXQgVXNlciBJRCAqLw0K
KwlfX3UzMgkJYWNfZ2lkMzI7CQkvKiBBY2NvdW50aW5nIFJlYWwgMzJiaXQg
R3JvdXAgSUQgKi8NCisJY2hhcgkJYWNfcGFkWzJdOwkJLyogQWNjb3VudGlu
ZyBQYWRkaW5nIEJ5dGVzICovDQogfTsNCiANCiAvKg0K
--279707962-865861748-1017847275=:21723--
