Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129860AbRAZLOD>; Fri, 26 Jan 2001 06:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129562AbRAZLNx>; Fri, 26 Jan 2001 06:13:53 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:59152 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129172AbRAZLNr>;
	Fri, 26 Jan 2001 06:13:47 -0500
From: Torben Mathiasen <torben@kernel.dk>
To: saw@saw.sw.com.sg, jgarzik@mandrakesoft.com
CC: linux-kernel@vger.kernel.org, scott@tranzoa.com
Subject: Re: eepro100 problems in 2.4.0
Reply-To: Torben Mathiasen <torben@kernel.dk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailer: kenstermail
X-attachments: ee100apm.diff
Content-Type: multipart/mixed;
	boundary="==================_846811060==_"
Content-Disposition: inline
Message-Id: <E14M6oz-0000dk-00@virtualhost.dk>
Date: Fri, 26 Jan 2001 12:13:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==================_846811060==_
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=iso-8859-1

On Friday, 26 January 2001, saw@saw.sw.com.sg wrote:
> Hi,
> 
> On Thu, Jan 25, 2001 at 04:19:27PM -0500, Jeff Garzik wrote:
> > Oops, sorry guys.  Thanks to DaveM for correcting me -- my patch has
> > nothing to do with the "card reports no resources" problem.  My
> > apologies.
> 
> No problems.
> 
> However, there is a real problem with eepro100 when the system resumes
> operations after a sleep.
> May be, you could guess what's wrong in this case?
> 

I had to add this small patch to make it work properly with my Armada
M700. It basiclly just does something similar to what happens when we
get TX timeouts. Its just a quick hack, as I got tired of the eepro100
driver dumping the tx/rx queues when resuming.

Regards,

Torben Mathiasen


--==================_846811060==_
Content-type: application/octet-stream; name="ee100apm.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ee100apm.diff"

LS0tIC9vcHQva2VybmVsL2tlcm5lbHMvbGludXgvZHJpdmVycy9uZXQvZWVwcm8xMDAuYwlUdWUg
Tm92IDI4IDAyOjU4OjMyIDIwMDAKKysrIGxpbnV4L2RyaXZlcnMvbmV0L2VlcHJvMTAwLmMJV2Vk
IEphbiAyNCAxNjoyNjoxNCAyMDAxCkBAIC0yMTQ1LDcgKzIxNDUsNyBAQAogewogCXN0cnVjdCBu
ZXRfZGV2aWNlICpkZXYgPSBwZGV2LT5kcml2ZXJfZGF0YTsKIAlzdHJ1Y3Qgc3BlZWRvX3ByaXZh
dGUgKnNwID0gKHN0cnVjdCBzcGVlZG9fcHJpdmF0ZSAqKWRldi0+cHJpdjsKLQlsb25nIGlvYWRk
ciA9IGRldi0+YmFzZV9hZGRyOworCWxvbmcgaW9hZGRyID0gZGV2LT5iYXNlX2FkZHIsIGZsYWdz
OwogCiAJLyogSSdtIGFic29sdXRlbHkgdW5jZXJ0YWluIGlmIHRoaXMgcGFydCBvZiBjb2RlIG1h
eSB3b3JrLgogCSAgIFRoZSBwcm9ibGVtcyBhcmU6CkBAIC0yMTU0LDEyICsyMTU0LDE5IEBACiAJ
CSAgcmVpbml0aWFsaXphdGlvbjsKIAkJLSBzZXJpYWxpemF0aW9uIHdpdGggb3RoZXIgZHJpdmVy
IGNhbGxzLgogCSAgIDIwMDAvMDMvMDggIFNBVyAqLworCW91dGwoUG9ydFJlc2V0LCBpb2FkZHIg
KyBTQ0JQb3J0KTsKKwl1ZGVsYXkoMTApOwogCW91dHcoU0NCTWFza0FsbCwgaW9hZGRyICsgU0NC
Q21kKTsKKwlzeW5jaHJvbml6ZV9pcnEoKTsKKwlzcGluX2xvY2tfaXJxc2F2ZSgmc3AtPmxvY2ss
IGZsYWdzKTsKIAlzcGVlZG9fcmVzdW1lKGRldik7Ci0JbmV0aWZfZGV2aWNlX2F0dGFjaChkZXYp
OworCWRldi0+dHJhbnNfc3RhcnQgPSBqaWZmaWVzOwogCXNwLT5yeF9tb2RlID0gLTE7CisJc3Bp
bl91bmxvY2tfaXJxcmVzdG9yZSgmc3AtPmxvY2ssIGZsYWdzKTsKKwluZXRpZl9kZXZpY2VfYXR0
YWNoKGRldik7CiAJc3AtPmZsb3dfY3RybCA9IHNwLT5wYXJ0bmVyID0gMDsKIAlzZXRfcnhfbW9k
ZShkZXYpOworCXJlc2V0X21paShkZXYpOwogfQogI2VuZGlmIC8qIENPTkZJR19FRVBSTzEwMF9Q
TSAqLwogCg==




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
--==================_846811060==_--
