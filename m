Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbTJAKku (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 06:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbTJAKku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 06:40:50 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:18597 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261406AbTJAKks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 06:40:48 -0400
Date: Wed, 1 Oct 2003 11:40:45 +0100 (IST)
From: "Cathal A. Ferris" <pio@csn.ul.ie>
X-X-Sender: pio@skynet
To: linux-kernel@vger.kernel.org
Subject: swsusp 2.6.0-test3 resuming issues
Message-ID: <Pine.LNX.4.58.0310011057500.7555@skynet>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-913833367-625558916-1065004845=:7555"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---913833367-625558916-1065004845=:7555
Content-Type: TEXT/PLAIN; charset=US-ASCII

I am having trouble with the suspend/resume area in -test3.
I suspend with 'echo 4 > /proc/acpi/sleep' after unloading as many of the
modules as possible (though usbcore won't unload) and it appears to
suspend correctly.
On resume I get 'Incorrect kernel version', and failure to resume from the
saved image.

Machine is a dell inspiron 4100 laptop running gentoo linux.
128mb ram
swaps:
minipio root # swapon -s
Filename                                Type         Size    Used    Priority
/dev/ide/host0/bus0/target0/lun0/part2   partition   530136  76400   -1
/dev/ide/host0/bus0/target0/lun0/part1   partition   441748  0       -2


What information do you want to assist with the resolution of this
problem?

(under -test6 I get no effect from either /proc/acpi/sleep or
/sys/power/state - i.e. I do the echo and absolutely nothing happens, and
nothing in the kernel logs)

Thanks,

Cathal.
-- 
Cathal Ferris.		+353 87 6438725
pio@csn.ul.ie		http://www.swibble.com
---913833367-625558916-1065004845=:7555
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=dmesg
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0310011140450.7555@skynet>
Content-Description: 
Content-Disposition: attachment; filename=dmesg

c2VyaW86IGk4MDQyIEtCRCBwb3J0IGF0IDB4NjAsMHg2NCBpcnEgMQ0KTkVU
NDogTGludXggVENQL0lQIDEuMCBmb3IgTkVUNC4wDQpJUDogcm91dGluZyBj
YWNoZSBoYXNoIHRhYmxlIG9mIDUxMiBidWNrZXRzLCA0S2J5dGVzDQpUQ1A6
IEhhc2ggdGFibGVzIGNvbmZpZ3VyZWQgKGVzdGFibGlzaGVkIDgxOTIgYmlu
ZCAxNjM4NCkNCk5FVDQ6IFVuaXggZG9tYWluIHNvY2tldHMgMS4wL1NNUCBm
b3IgTGludXggTkVUNC4wLg0KQUNQSTogKHN1cHBvcnRzIFMwIFMxIFMzIFM0
IFM0YmlvcyBTNSkNClJlc3VtZSBNYWNoaW5lOiByZXN1bWluZyBmcm9tIC9k
ZXYvaGRhMQ0KUmVzdW1pbmcgZnJvbSBkZXZpY2UgaGRhMQ0KUmVzdW1lIE1h
Y2hpbmU6IFNpZ25hdHVyZSBmb3VuZCwgcmVzdW1pbmcNClJlc3VtZSBNYWNo
aW5lOiBJbmNvcnJlY3Qga2VybmVsIHZlcnNpb24NClJlc3VtZSBNYWNoaW5l
OiBFcnJvciAtMSByZXN1bWluZyANCkVYVDMtZnM6IElORk86IHJlY292ZXJ5
IHJlcXVpcmVkIG9uIHJlYWRvbmx5IGZpbGVzeXN0ZW0uDQpFWFQzLWZzOiB3
cml0ZSBhY2Nlc3Mgd2lsbCBiZSBlbmFibGVkIGR1cmluZyByZWNvdmVyeS4N
Cmtqb3VybmFsZCBzdGFydGluZy4gIENvbW1pdCBpbnRlcnZhbCA1IHNlY29u
ZHMNCkVYVDMtZnM6IHJlY292ZXJ5IGNvbXBsZXRlLg0KRVhUMy1mczogbW91
bnRlZCBmaWxlc3lzdGVtIHdpdGggb3JkZXJlZCBkYXRhIG1vZGUuDQpWRlM6
IE1vdW50ZWQgcm9vdCAoZXh0MyBmaWxlc3lzdGVtKSByZWFkb25seS4NCkZy
ZWVpbmcgdW51c2VkIGtlcm5lbCBtZW1vcnk6IDE0NGsgZnJlZWQNCkFkZGlu
ZyA1MzAxMzZrIHN3YXAgb24gL2Rldi9oZGEyLiAgUHJpb3JpdHk6LTEgZXh0
ZW50czoxDQpVbmFibGUgdG8gZmluZCBzd2FwLXNwYWNlIHNpZ25hdHVyZQ0K
DQo=

---913833367-625558916-1065004845=:7555--
