Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbTDKSib (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 14:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbTDKSib (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 14:38:31 -0400
Received: from [64.246.18.23] ([64.246.18.23]:10444 "EHLO ensim.2hosting.net")
	by vger.kernel.org with ESMTP id S261346AbTDKSi3 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 14:38:29 -0400
From: "Steve Lee" <steve@tuxsoft.com>
To: <freesoftwaredeveloper@web.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [ANNOUNCE] udev 0.1 release
Date: Fri, 11 Apr 2003 13:50:16 -0500
Message-ID: <001f01c3005b$362a1f60$0201a8c0@pluto>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <200304112018.11931.freesoftwaredeveloper@web.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, 1998 3 into 1 splitters would be needed.  The break down is as
follows:

Three of the original power connectors would need 400 splitters, while
the remaining two would just need 399 splitters.  This would result in
4001 power connectors, or 4001 disks.  Because it's a Friday, here is a
simple program that verified my findings.

int main(int argc,char **argv)
{
    int con_a,con_b,con_c,con_d,con_e;
    int pow_a,pow_b,pow_c,pow_d,pow_e;

    con_a=con_b=con_c=con_d=con_e=0;
    pow_a=pow_b=pow_c=pow_d=pow_e=1;
    while(1) {
        con_a++;
        pow_a=con_a*3-(con_a==1?0:con_a-1);
        if(pow_a+pow_b+pow_c+pow_d+pow_e>=4000)
            break;
        con_b++;
        pow_b=con_b*3-(con_b==1?0:con_b-1);
        if(pow_a+pow_b+pow_c+pow_d+pow_e>=4000)
            break;
        con_c++;
        pow_c=con_c*3-(con_c==1?0:con_c-1);
        if(pow_a+pow_b+pow_c+pow_d+pow_e>=4000)
            break;
        con_d++;
        pow_d=con_d*3-(con_d==1?0:con_d-1);
        if(pow_a+pow_b+pow_c+pow_d+pow_e>=4000)
            break;
        con_e++;
        pow_e=con_e*3-(con_e==1?0:con_e-1);
        if(pow_a+pow_b+pow_c+pow_d+pow_e>=4000)
            break;
    }
    fprintf(stderr,"con_a = %d, pow_a = %d\n",con_a,pow_a);
    fprintf(stderr,"con_b = %d, pow_b = %d\n",con_b,pow_b);
    fprintf(stderr,"con_c = %d, pow_c = %d\n",con_c,pow_c);
    fprintf(stderr,"con_d = %d, pow_d = %d\n",con_d,pow_d);
    fprintf(stderr,"con_e = %d, pow_e = %d\n",con_e,pow_e);
    fprintf(stderr,"pow_a+pow_b+pow_c+pow_d+pow_e =
%d\n",pow_a+pow_b+pow_c+pow_d+pow_e);
    return 0;
}

-----Original Message-----
From: freesoftwaredeveloper@web.de [mailto:freesoftwaredeveloper@web.de]

Sent: Friday, April 11, 2003 1:18 PM
To: oliver@neukum.name
Cc: Steve Lee; Desmet_Jochen@emc.com
Subject: Re: [ANNOUNCE] udev 0.1 release

On Friday 11 April 2003 20:15, Oliver Neukum wrote:
> Am Freitag, 11. April 2003 20:03 schrieb Michael Buesch:
> > On Friday 11 April 2003 19:46, John Bradford wrote:
> > > [Puzzle]
> > > Say the power supply had five 5.25" drive power connecters, how
many 1
> > > into 3 power cable splitters would you need to connect all 4000
disks?

> You are hereby hit. All drivers need to be connected to a splitter.
> Thus any answer under 4000/3 must be wrong.

Yea, but: "Say the power supply had five 5.25" drive power connecters"
:)

-- 
My homepage: http://www.8ung.at/tuxsoft
fighting for peace is like fu**ing for virginity


