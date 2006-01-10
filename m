Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWAJKx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWAJKx4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 05:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWAJKxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 05:53:55 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:52013 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932177AbWAJKxz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 05:53:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=pJSQ5R5nGyT6rZEuO8tN1KKDnFxQxgeJHWsuWGCoHZ3dunBXlbOZLV4b1EjrIG73BHykAxk72qY/KRtlqA80TCXPSK0Y2at4AoWXeRdG3yaKmMyyZEIyJ0sSpMFTp5qkj7SEPKOUcw/3XmIdWalOeIkmLpCxWi3ltXLfS22Wy/E=
Message-ID: <f0309ff0601100253k219757b9g5a9030c89235d0f2@mail.gmail.com>
Date: Tue, 10 Jan 2006 02:53:53 -0800
From: Nauman Tahir <nauman.tahir@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: X86_64 and X86_32 bit performance difference [Revisited]
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.kernel.org
In-Reply-To: <f0309ff0601100249y4ffa3596sa2a623015cdca66b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_108145_29779094.1136890433749"
References: <f0309ff0601082229u3fc5e415m12be9dc921f4a099@mail.gmail.com>
	 <1136793080.2936.14.camel@laptopd505.fenrus.org>
	 <f0309ff0601100249y4ffa3596sa2a623015cdca66b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_108145_29779094.1136890433749
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 1/10/06, Nauman Tahir <nauman.tahir@gmail.com> wrote:
> On 1/9/06, Arjan van de Ven <arjan@infradead.org> wrote:
> > On Sun, 2006-01-08 at 22:29 -0800, Nauman Tahir wrote:
> > > Hello All
> > > I have posted this problem before. Now mailing again after testing as
> > > recommeded in previous replys.
> > > My configuration is:
> > >
> > > Hardware:
> > > HP Proliant DL145 (2 x AMD Optaron 144)
> > > 14 GB RAM
> > >
> > > OS:
> > > FC 4
> > >
> > > Kernel
> > > 2.6.xx
> >
> > You *STILL* have not posted the URL to your source code.
> > How is anyone supposed to help you without that?????
>
> I have attached a file which I use as thread API. Complete code is
> quiet large and also need proper description. which i would be posting
> if needed.
> I hope I make my problem clear: I repeat : same code is giving alot of
> performance degradation on previously mentioned configuration. One
> suspect is the thread library.
>
>
> dts_thread_t *dts_register_thread(void (*run) (void *),  const char
> *name, void * private)
>
> is the function to register my thread handler
>
> void dts_wakeup_thread(dts_thread_t *thread)
>
> is the function in the dts_thread.c which i use to run my thread.
>
> all my thread handlers either
> call generic_make_request some times for my RAMDISK and sometimes for
> my Target device [SCSI DISK or local HDD partition]
> OR
> uses list.h
>
>
>
> >
> >
> >
> >
> >
>

------=_Part_108145_29779094.1136890433749
Content-Type: text/plain; name="dts_thread.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dts_thread.c"

CiNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4KI2luY2x1
ZGUgPGxpbnV4L2tlcm5lbC5oPgojaW5jbHVkZSA8bGludXgvc21wX2xvY2suaD4KCgojaW5jbHVk
ZSA8bGludXgvbWVtcG9vbC5oPgojaW5jbHVkZSA8bGludXgvc2xhYi5oPgoKI2luY2x1ZGUgIi4u
L2luY2x1ZGUvZHRzX3RocmVhZC5oIgoKCiNkZWZpbmUgVEhSRUFEX1dBS0VVUCAweDAxCmV4dGVy
biB2b2lkIGR0c19zZXRfYml0KGNoYXIgKiAsIGludCApOwoKCmludCBkdHNfdGhyZWFkKHZvaWQg
KiBhcmcpCnsKCWR0c190aHJlYWRfdCAqdGhyZWFkID0gYXJnOwoKCWxvY2tfa2VybmVsKCk7CgoJ
LyoKCSAqIERldGFjaCB0aHJlYWQKCSAqLwoKCWRhZW1vbml6ZSh0aHJlYWQtPm5hbWUpOwoKCWN1
cnJlbnQtPmV4aXRfc2lnbmFsID0gU0lHQ0hMRDsKCWFsbG93X3NpZ25hbChTSUdLSUxMKTsKCXRo
cmVhZC0+dHNrID0gY3VycmVudDsKCgl1bmxvY2tfa2VybmVsKCk7CgoJY29tcGxldGUodGhyZWFk
LT5ldmVudCk7Cgl3aGlsZSAodGhyZWFkLT5ydW4pIHsKCQl2b2lkICgqcnVuKSh2b2lkICopOwoK
CQl3YWl0X2V2ZW50X2ludGVycnVwdGlibGUodGhyZWFkLT53cXVldWUsCgkJCQkJIHRlc3RfYml0
KFRIUkVBRF9XQUtFVVAsICZ0aHJlYWQtPmZsYWdzKSk7CgkJaWYgKGN1cnJlbnQtPmZsYWdzICYg
UEZfRlJFRVpFKQoJCQlyZWZyaWdlcmF0b3IoUEZfRlJFRVpFKTsKCgkJY2xlYXJfYml0KFRIUkVB
RF9XQUtFVVAsICZ0aHJlYWQtPmZsYWdzKTsKCgkJcnVuID0gdGhyZWFkLT5ydW47CgkJaWYgKHJ1
bikKCQkJcnVuKHRocmVhZC0+cHJpdmF0ZSk7CgoJCWlmIChzaWduYWxfcGVuZGluZyhjdXJyZW50
KSkKCQkJZmx1c2hfc2lnbmFscyhjdXJyZW50KTsKCX0KCWNvbXBsZXRlKHRocmVhZC0+ZXZlbnQp
OwoJcmV0dXJuIDA7Cn0KCnZvaWQgZHRzX3dha2V1cF90aHJlYWQoZHRzX3RocmVhZF90ICp0aHJl
YWQpCnsKCWlmICh0aHJlYWQpIHsKCgkJZHRzX3NldF9iaXQoKGNoYXIgKikmdGhyZWFkLT5mbGFn
cywgVEhSRUFEX1dBS0VVUCk7CgkJd2FrZV91cCgmdGhyZWFkLT53cXVldWUpOwoJfQoJZWxzZQoJ
cHJpbnRrKCJkdHNfd2FrZXVwX3RocmVhZDouLi4uLi4uLi50aHJlYWQgaXMgTlVMTFxuIik7Cn0K
CmR0c190aHJlYWRfdCAqZHRzX3JlZ2lzdGVyX3RocmVhZCh2b2lkICgqcnVuKSAodm9pZCAqKSwg
IGNvbnN0IGNoYXIgKm5hbWUsIHZvaWQgKiBwcml2YXRlKQp7CglkdHNfdGhyZWFkX3QgKnRocmVh
ZD1OVUxMOwoJaW50IHJldDsKCXN0cnVjdCBjb21wbGV0aW9uIGV2ZW50OwoKCXRocmVhZCA9IChk
dHNfdGhyZWFkX3QgKikga21hbGxvYwoJCQkJKHNpemVvZihkdHNfdGhyZWFkX3QpLCBHRlBfS0VS
TkVMKTsKCWlmICghdGhyZWFkKQoJCXJldHVybiBOVUxMOwoKCW1lbXNldCh0aHJlYWQsIDAsIHNp
emVvZihkdHNfdGhyZWFkX3QpKTsKCWluaXRfd2FpdHF1ZXVlX2hlYWQoJnRocmVhZC0+d3F1ZXVl
KTsKCglpbml0X2NvbXBsZXRpb24oJmV2ZW50KTsKCXRocmVhZC0+ZXZlbnQgPSAmZXZlbnQ7Cgl0
aHJlYWQtPnJ1biA9IHJ1bjsKCXRocmVhZC0+bmFtZSA9IG5hbWU7Cgl0aHJlYWQtPnByaXZhdGUg
PSBwcml2YXRlOwoKCXJldCA9IGtlcm5lbF90aHJlYWQoZHRzX3RocmVhZCwgdGhyZWFkLCAwKTsK
CWlmIChyZXQgPCAwKSB7CgkJcHJpbnRrKCJcbmR0c19yZWdpc3Rlcl90aHJlYWQ6Li4uLi4uLnVu
YWJsZSB0byByZWdpc3RlciBrZXJuZWwgdGhyZWFkXG4iKTsKCQlrZnJlZSh0aHJlYWQpOwoJCXJl
dHVybiBOVUxMOwoJfQoJd2FpdF9mb3JfY29tcGxldGlvbigmZXZlbnQpOwoKLy8JcHJpbnRrKCJU
aHJlYWQgQWxsb2NhdGVkIFN1Y2Nlc3NmdWxseVxuICIpOwoJcmV0dXJuIHRocmVhZDsKfQoKdm9p
ZCBkdHNfaW50ZXJydXB0X3RocmVhZChkdHNfdGhyZWFkX3QgKnRocmVhZCkKewoJaWYgKCF0aHJl
YWQtPnRzaykgewoJCUJVRygpOwoJCXJldHVybjsKCX0KLy8JZHByaW50aygiaW50ZXJydXB0aW5n
IGR0cy10aHJlYWQgcGlkICVkXG4iLCB0aHJlYWQtPnRzay0+cGlkKTsKCXNlbmRfc2lnKFNJR0tJ
TEwsIHRocmVhZC0+dHNrLCAxKTsKfQoKdm9pZCBkdHNfdW5yZWdpc3Rlcl90aHJlYWQoZHRzX3Ro
cmVhZF90ICp0aHJlYWQpCnsKCXN0cnVjdCBjb21wbGV0aW9uIGV2ZW50OwoKCWluaXRfY29tcGxl
dGlvbigmZXZlbnQpOwoKCXRocmVhZC0+ZXZlbnQgPSAmZXZlbnQ7Cgl0aHJlYWQtPnJ1biA9IE5V
TEw7Cgl0aHJlYWQtPm5hbWUgPSBOVUxMOwoJZHRzX2ludGVycnVwdF90aHJlYWQodGhyZWFkKTsK
CXdhaXRfZm9yX2NvbXBsZXRpb24oJmV2ZW50KTsKCWtmcmVlKHRocmVhZCk7Cn0KCkVYUE9SVF9T
WU1CT0woZHRzX3dha2V1cF90aHJlYWQpOwpFWFBPUlRfU1lNQk9MKGR0c191bnJlZ2lzdGVyX3Ro
cmVhZCk7CkVYUE9SVF9TWU1CT0woZHRzX3JlZ2lzdGVyX3RocmVhZCk7CkVYUE9SVF9TWU1CT0wo
ZHRzX2ludGVycnVwdF90aHJlYWQpOwoK
------=_Part_108145_29779094.1136890433749--
