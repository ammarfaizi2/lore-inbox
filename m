Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267020AbSLQWv2>; Tue, 17 Dec 2002 17:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266690AbSLQWv2>; Tue, 17 Dec 2002 17:51:28 -0500
Received: from mailnw.centurytel.net ([209.206.160.237]:761 "EHLO
	mailnw.centurytel.net") by vger.kernel.org with ESMTP
	id <S267020AbSLQWv0>; Tue, 17 Dec 2002 17:51:26 -0500
Message-ID: <3E001D07.5010006@centurytel.net>
Date: Wed, 18 Dec 2002 00:00:23 -0700
From: eric lin <fsshl@centurytel.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021210 Debian/1.2.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: James Simmons <jsimmons@infradead.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.52 compile error
References: <Pine.LNX.4.44.0212172152350.24589-100000@phoenix.infradead.org>
In-Reply-To: <Pine.LNX.4.44.0212172152350.24589-100000@phoenix.infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:
>>All of these options are modules in my config file, *must* they be built
>>into the kernel in order to compile?
> 
> 
> Yes!!! I have a patch for fixing this issue.
> 
> You can import this changeset into BK by piping this whole message to:
> '| bk receive [path to repository]' or apply the patch as usual.
> 
> ===================================================================
> 
> 
> ChangeSet@1.868, 2002-12-10 12:07:45-08:00, jsimmons@kozmo.(none)
>   The VT tty layer depends on the input api now. Fixed this dependency.
> 
> 
>  Kconfig |    1 +
>  1 files changed, 1 insertion(+)
> 
> 
> diff -Nru a/drivers/char/Kconfig b/drivers/char/Kconfig
> --- a/drivers/char/Kconfig	Tue Dec 10 12:16:48 2002
> +++ b/drivers/char/Kconfig	Tue Dec 10 12:16:48 2002
> @@ -6,6 +6,7 @@
> 
>  config VT
>  	bool "Virtual terminal"
> +	depends on INPUT=y
>  	---help---
>  	  If you say Y here, you will get support for terminal devices with
>  	  display and keyboard devices. These are called "virtual" because you
> 
> ===================================================================
> 
> 
> This BitKeeper patch contains the following changesets:
I copied this piece as patch1.tar.gz
--------------------------------------------------------------
> +
> ## Wrapped with gzip_uu ##
> 
> 
> begin 664 bkpatch6044
> M'XL(`+!+]CT``]54VVH;,1!]MKYB("\MQ;NZ[,T+6]RFEX24UKA.7TH?A';L
> MW=@KF97L9,-^?&6[N1!,H*5]J"X(9H;#F3D'G<"EQ38?7-FZ:8RVY`3.C'7Y
> M8&EN&Q.\T$;C2Q^<&N.#X<:VH6U5N*KUYF98Z_7&$9^=2*<JV&)K\P$+Q'W$
> M=6O,!]/W'R\_O9D24A1P6DF]P*_HH"B(,^U6KDH[EJY:&1VX5FK;H).!,DU_
> M7]IS2KG?,4L%C9.>)31*>\5*QF3$L*0\RI*(W+4P?DS]"0KCC+)1%,6C7B24
> M"?(.6)`E&5`>,G\H,)[3-(_B(<UR2N$H*+QB,*3D+?S=!DZ)@EF%\&T&SG6P
> MDAVV4.(:=6G!:'`^MQ\YR'4-VEP'\*&^P=(G:ONK$+7J`B`7(.(TC<CD8>!D
> M^)N+$"HI>0VW]7J-J_%!\B;)EH%I%]_O6O_1EVV]4SY4E6S#"V7TO%X<ADT%
> MI9'@/.LYIUG6BU0D*.99R>>E$!R/3_<90`_IWY1Y]40<97M'':O>F>O?T2:E
> MW.+56)D2/?DE=COD8+-\!I)Q?^/$JR[8B!]L)YZ:CHW^>]/M5?D"P_9Z?[R)
> L)D<%^@,SGF?`R.`1L_//D\M9T3W\/ZI"M;2;IE!2\7B$2'X"W[RZ@MX$````
> `
> end
> 
-------------------------------------------------------------------
then in my /linux-2.5.52/

fsshl@www:~/linux-2.5.52$ gzip -cd patch1.tar.gz | patch -p1
patch: **** Only garbage was found in the patch input.

Please help

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


-- 
Sincere Eric
www.linuxspice.com
linux pc for sale

