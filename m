Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129108AbRBTQt1>; Tue, 20 Feb 2001 11:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129115AbRBTQtR>; Tue, 20 Feb 2001 11:49:17 -0500
Received: from tomts7.bellnexxia.net ([209.226.175.40]:42408 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129108AbRBTQtK>; Tue, 20 Feb 2001 11:49:10 -0500
Message-ID: <3A929DF2.CDA7F949@sympatico.ca>
Date: Tue, 20 Feb 2001 11:40:18 -0500
From: Jeremy Jackson <jeremy.jackson@sympatico.ca>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Xavier Bestel <xavier.bestel@free.fr>
CC: Andreas Bombe <andreas.bombe@munich.netsurf.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Is this the ultimate stack-smash fix?
In-Reply-To: <3A899FEB.D54ABBC7@sympatico.ca>  
		<m1lmr98c5t.fsf@frodo.biederman.org> <3A8ADA30.2936D3B1@sympatico.ca>  
		<m1hf1w8qea.fsf@frodo.biederman.org> <3A8BF5ED.1C12435A@colorfullife.com>  
		<m1k86s6imn.fsf@frodo.biederman.org> <20010217084330.A17398@cadcamlab.org>  
		<m1y9v4382r.fsf@frodo.biederman.org>  <20010220021012.A1481@storm.local> <200102200909.KAA12190@microsoft.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Bestel wrote:

> Le 20 Feb 2001 02:10:12 +0100, Andreas Bombe a écrit :
> >
> > An array is a word that contains the address of the first element.
>
> No. Exercise 3: compile and run this:
> file a.c:
> char array[] = "I'm really an array";
>
> file b.c:
> extern char* array;
> main() { printf("array = %s\n", array); }
>

try file b.c
extern char array;
main() { printf("array= %s\n", &array); }

?

>
> ... and watch it biting the dust !
> in short: an array is NOT a pointer.

