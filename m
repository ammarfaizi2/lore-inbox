Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130255AbQL2OkM>; Fri, 29 Dec 2000 09:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131266AbQL2OkC>; Fri, 29 Dec 2000 09:40:02 -0500
Received: from air.lug-owl.de ([62.52.24.190]:45329 "HELO air.lug-owl.de")
	by vger.kernel.org with SMTP id <S129838AbQL2Ojp> convert rfc822-to-8bit;
	Fri, 29 Dec 2000 09:39:45 -0500
Date: Fri, 29 Dec 2000 15:09:14 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org, linux-kbuild@torque.net
Subject: Re: [PATCH] Processor autodetection (when configuring kernel)
Message-ID: <20001229150913.A18678@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-kbuild@torque.net
In-Reply-To: <3A4C941E.EA824F87@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A4C941E.EA824F87@student.ethz.ch>; from cate@student.ethz.ch on Fri, Dec 29, 2000 at 02:39:42PM +0100
X-Operating-System: Linux air 2.4.0-test8-pre1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2000 at 02:39:42PM +0100, Giacomo A. Catenazzi wrote:
> +  case $cpu_id in
> +    GenuineIntel:5:[0123]      )  echo CONFIG_M586TSC   ;;
> +    GenuineIntel:5:[48]        )  echo CONFIG_M586MMX   ;;
> +    GenuineIntel:6:[01356]     )  echo CONFIG_M686      ;;
> +    GenuineIntel:6:{8,9,11}    )  echo CONFIG_M686FXSR  ;;
> +    AuthenticAMD:5:[0123]      )  echo CONFIG_M586      ;;
> +    AuthenticAMD:5:{8,9,10,11} )  echo CONFIG_MK6       ;;
> +    AuthenticAMD:6:[0124]      )  echo CONFIG_MK7       ;;
> +    UMC:4:[12]                 )  echo CONFIG_M486      ;; # "UMC" !
> +    NexGenDriven:5:0           )  echo CONFIG_M386      ;;
> +    {TransmetaCPU,GenuineTMx86}:* ) echo CONFIG_MCROSUE ;;   

What about non-ia32 processor based systems? I'd ivolunteer to
extend the patch, but I'd need *your* /proc/cpuinfo... I think
that's worth it...

MfG, JBG

-- 
Fehler eingestehen, Größe zeigen: Nehmt die Rechtschreibreform zurück!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=0x8399E1BB fingerprint=250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 8399 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
