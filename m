Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262721AbTCPS0O>; Sun, 16 Mar 2003 13:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262722AbTCPS0O>; Sun, 16 Mar 2003 13:26:14 -0500
Received: from modemcable011.162-200-24.mtl.mc.videotron.ca ([24.200.162.11]:17537
	"HELO chezsoi") by vger.kernel.org with SMTP id <S262721AbTCPS0M> convert rfc822-to-8bit;
	Sun, 16 Mar 2003 13:26:12 -0500
From: "James Watkins-Harvey" <james.watkins-harvey.1@ens.etsmtl.ca>
To: "Maxime" <x@organigramme.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: PROBLEM: make bzImage fails when LANG set
Date: Sun, 16 Mar 2003 13:38:48 -0500
Message-ID: <FAEHLJECFOOHNNMFHACOCEJICAAA.james.watkins-harvey.1@ens.etsmtl.ca>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
In-Reply-To: <3E74AC1C.8010901@organigramme.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> /usr/src/linux-2.4.19/include/linux/kernel.h:10:20: stdarg.h: Aucun fichier ou répertoire de ce type
> /usr/src/linux-2.4.19/include/linux/kernel.h:73: erreur d'analyse syntaxique avant « va_list »
> /usr/src/linux-2.4.19/include/linux/kernel.h:73: AVERTISSEMENT:  déclaration de fonction n'est pas un prototype
> /usr/src/linux-2.4.19/include/linux/kernel.h:76: erreur d'analyse syntaxique avant « va_list »
> /usr/src/linux-2.4.19/include/linux/kernel.h:76: AVERTISSEMENT: déclaration de fonction n'est pas un prototype
> /usr/src/linux-2.4.19/include/linux/kernel.h:80: erreur d'analyse syntaxique avant « va_list »
> /usr/src/linux-2.4.19/include/linux/kernel.h:80: AVERTISSEMENT: déclaration de fonction n'est pas un prototype


The first line just means that the stdarg.h file cannot be found; following lines are consequence of the va_list macro not being included.  Well stdarg.h is provided by GCC, so it seems to me like this is rather a GCC problem...  Let's continue, in case a defective makefile would be in cause...



> Notice it is in french.  I search on the web for similar problem, and 
> find a few examples, all in foreing language.  Nobody seemed to know how 
> to solve this.  I then remembered I added these lines to my /etc/profile:
>
> export LANG=fr
> export LC_ALL=fr_CA
>
> By removing them, the kernel compiled just fine.  Stange bug!


I don't know very well about the LC_ALL consequence, but it seems that GCC use it (and also LANG) for some reason...

Guess it could help including the GCC version (gcc -v) and the location of any stdarg.h file on your drive (locate stdarg.h  or  find /usr -name stdarg.h, the second may be long).  If you have some spare time, also try using only the LANG, then only the LC_ALL.


James Watkins-Harvey


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

