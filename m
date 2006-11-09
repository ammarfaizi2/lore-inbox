Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753759AbWKIHgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759AbWKIHgT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 02:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753769AbWKIHgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 02:36:19 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:49470 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1753760AbWKIHgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 02:36:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=SlsaQduZ5bxB3fvbUhWhSQY8SP+ZlE6arey6g7a31CjSuul6XRiZcHH75rXTqynXYlv7nh0ChzrhXXnv4zNcQt+gsBrxlJ5yM4Af63f/I43FX9mFv7GMdS0Gae4b+nt8EtpZRKgTKgs5pIExfM+r4mVmMw/QD3XEYiDe/5FnW2Q=
Message-ID: <86802c440611082336l26ad9c94i49e805097c3a00b4@mail.gmail.com>
Date: Wed, 8 Nov 2006 23:36:16 -0800
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: Horms <horms@verge.net.au>
Subject: Re: [Fastboot] Kexec with latest kernel fail
Cc: yhlu <yinghailu@gmail.com>,
       "Fastboot mailing list" <fastboot@lists.osdl.org>,
       ebiederm@xmission.com, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061109062124.GB28415@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5986589C150B2F49A46483AC44C7BCA49071BF@ssvlexmb2.amd.com>
	 <20061109054805.GA28415@verge.net.au>
	 <2ea3fae10611082204k5316379fsd33a33954c58ab4b@mail.gmail.com>
	 <20061109062124.GB28415@verge.net.au>
X-Google-Sender-Auth: f4f0fea39eebc00d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

.  ..  AUTHORS  config  configure.ac  COPYING  doc  .git  include
kdump  kexec  kexec_test  kexec-tools.spec.in  Makefile
Makefile.conf.in  News  purgatory  TODO  util  util_lib
yhlunb:/home/yhlu/xxx/xx/kernel/kexec-tools-testing # make
Makefile:2: Makefile.conf: No such file or directory
util_lib/Makefile:10: /util_lib/compute_ip_checksum.d: No such file or directory
util_lib/Makefile:10: /util_lib/sha256.d: No such file or directory
purgatory/Makefile:30: purgatory/arch//Makefile: No such file or directory
purgatory/Makefile:42: /purgatory/purgatory.d: No such file or directory
purgatory/Makefile:42: /purgatory/printf.d: No such file or directory
purgatory/Makefile:42: /purgatory/string.d: No such file or directory
kexec/Makefile:23: kexec/arch//Makefile: No such file or directory
make: execvp: ./AUTHORS: Permission denied
mkdir -p /kdump
cc   -M kdump/kdump.c | sed -e 's|kdump.o|/kdump/kdump.o|' > /kdump/kdump.d
mkdir -p /kexec
cc   -Ikexec/arch//include -M kexec/crashdump.c | sed -e
's|crashdump.o|/kexec/crashdump.o|' > /kexec/crashdump.d
mkdir -p /kexec
cc   -Ikexec/arch//include -M kexec/kexec-elf-boot.c | sed -e
's|kexec-elf-boot.o|/kexec/kexec-elf-boot.o|' >
/kexec/kexec-elf-boot.d
kexec/kexec-elf-boot.c:26:27: error: boot/elf_boot.h: No such file or directory
kexec/kexec-elf-boot.c:27:25: error: ip_checksum.h: No such file or directory
kexec/kexec-elf-boot.c:28:27: error: x86/x86-linux.h: No such file or directory
mkdir -p /kexec
cc   -Ikexec/arch//include -M kexec/kexec-elf-rel.c | sed -e
's|kexec-elf-rel.o|/kexec/kexec-elf-rel.o|' > /kexec/kexec-elf-rel.d
kexec/kexec-elf-rel.c:8:27: error: boot/elf_boot.h: No such file or directory
mkdir -p /kexec
cc   -Ikexec/arch//include -M kexec/kexec-elf-core.c | sed -e
's|kexec-elf-core.o|/kexec/kexec-elf-core.o|' >
/kexec/kexec-elf-core.d
mkdir -p /kexec
cc   -Ikexec/arch//include -M kexec/kexec-elf-exec.c | sed -e
's|kexec-elf-exec.o|/kexec/kexec-elf-exec.o|' >
/kexec/kexec-elf-exec.d
kexec/kexec-elf-exec.c:8:27: error: boot/elf_boot.h: No such file or directory
mkdir -p /kexec
cc   -Ikexec/arch//include -M kexec/kexec-elf.c | sed -e
's|kexec-elf.o|/kexec/kexec-elf.o|' > /kexec/kexec-elf.d
kexec/kexec-elf.c:8:27: error: boot/elf_boot.h: No such file or directory
mkdir -p /kexec
cc   -Ikexec/arch//include -M kexec/ifdown.c | sed -e
's|ifdown.o|/kexec/ifdown.o|' > /kexec/ifdown.d
mkdir -p /kexec
cc   -Ikexec/arch//include -M kexec/kexec.c | sed -e
's|kexec.o|/kexec/kexec.o|' > /kexec/kexec.d
kexec/kexec.c:35:20: error: sha256.h: No such file or directory
kexec/kexec.c:40:26: error: arch/options.h: No such file or directory
make: *** No rule to make target `kexec/arch//Makefile'.  Stop.
