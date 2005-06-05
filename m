Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbVFEKVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbVFEKVq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 06:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVFEKVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 06:21:46 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:43140 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261547AbVFEKVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 06:21:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=mv6A9cviyVqtEVrwbhUsjgwMlffoa+qotJdodAGgW2oGxwkaSzvvffm94KmdmypBEAaTlarxtW6+zNVqN2nwuMkcF52VUdnnxCUnnTV5b59SfZm2OvZOIvq0KkEfEtzbj6LJodByGCyFJuw2srT0BlmpeocuTEV4r2X3oRIDh9o=
Message-ID: <65258a580506050321f1eeab0@mail.gmail.com>
Date: Sun, 5 Jun 2005 12:21:43 +0200
From: Vincent Vanackere <vincent.vanackere@gmail.com>
Reply-To: Vincent Vanackere <vincent.vanackere@gmail.com>
To: linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>, thoffman@arnor.net
Subject: PROBLEM: atiremote input doesn`t register `device` & `driver` section in sysfs (/sys/class/input/event#)
Cc: "Viktor A. Danilov" <__die@mail.ru>
In-Reply-To: <20050412074121.GE1371@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_6816_31085628.1117966903712"
References: <200504101921.28777.__die@mail.ru>
	 <20050412074121.GE1371@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_6816_31085628.1117966903712
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> On Sun, Apr 10, 2005 at 07:21:28PM +0600, Viktor A. Danilov wrote:
> >
> > PROBLEM: aiptek input doesn`t register `device` & `driver` section in s=
ysfs (/sys/class/input/event#)
> > REASON: `dev` - field not filled...
> > SOLUTION: in linux/drivers/usb/input/aiptek.c write
> >       aiptek->inputdev.dev =3D &intf->dev;
> > before calling
> >       input_register_device(&aiptek->inputdev);

Hi,

 The following (tested) patch fixes the exact same issue with the ATI
Remote input driver.

Best regards,

Vincent

------=_Part_6816_31085628.1117966903712
Content-Type: text/plain; name="patch_ati.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch_ati.txt"

LS0tIGxpbnV4LTIuNi4xMS9kcml2ZXJzL3VzYi9pbnB1dC9hdGlfcmVtb3RlLmMJMjAwNS0wNS0w
OSAxNjoyMDoxOS4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi4xMi1yYzUvZHJpdmVycy91
c2IvaW5wdXQvYXRpX3JlbW90ZS5jCTIwMDUtMDYtMDUgMTE6NDA6NTguMDAwMDAwMDAwICswMjAw
CkBAIC02NTQsNiArNjU0LDcgQEAKIAlpZGV2LT5pZC52ZW5kb3IgPSBsZTE2X3RvX2NwdShhdGlf
cmVtb3RlLT51ZGV2LT5kZXNjcmlwdG9yLmlkVmVuZG9yKTsKIAlpZGV2LT5pZC5wcm9kdWN0ID0g
bGUxNl90b19jcHUoYXRpX3JlbW90ZS0+dWRldi0+ZGVzY3JpcHRvci5pZFByb2R1Y3QpOwogCWlk
ZXYtPmlkLnZlcnNpb24gPSBsZTE2X3RvX2NwdShhdGlfcmVtb3RlLT51ZGV2LT5kZXNjcmlwdG9y
LmJjZERldmljZSk7CisJaWRldi0+ZGV2ID0gJihhdGlfcmVtb3RlLT51ZGV2LT5kZXYpOwogfQog
CiBzdGF0aWMgaW50IGF0aV9yZW1vdGVfaW5pdGlhbGl6ZShzdHJ1Y3QgYXRpX3JlbW90ZSAqYXRp
X3JlbW90ZSkK
------=_Part_6816_31085628.1117966903712--
