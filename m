Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbTDKWhy (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 18:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbTDKWhx (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 18:37:53 -0400
Received: from watch.techsource.com ([209.208.48.130]:24469 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S261875AbTDKWhe (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 18:37:34 -0400
Message-ID: <3E974989.6030009@techsource.com>
Date: Fri, 11 Apr 2003 19:02:33 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Painlessly shrinking kernel messages (Re: kernel support for
 non-english user messages)
References: <3E95EB6D.4020004@techsource.com> <1050010963.12494.132.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This time, my text compression program ignores word boundaries.  Below 
are the results.

"shrink" is the size reduction due to replacing the given string with a 
one-byte code. (accounts for space required for codes and the decode 
string plus nul).
"count"  is how many times the string appears.
Strings are delimited by [brackets].

At the end, the "original size" accounts for null termination for all 
strings.  
The "new size" is the size of the text with the codes inserted plus the 
amount of space required to store what the codes map to.

Nothing accounts for the space wasted due to the strings being 32-bit 
aligned or whatever various architectures might require.  This is just 
an estimate.

What the heck is "[^_]" ?  Is it a machine instruction that 'strings' is 
mistaking for a string?  I grep'd through the kernel source and didn't 
find it.


The results are that the kernel messages are reduced from 232690 to 
154365, which is a savings of 33%.  Not bad, but it's probably still not 
worth it yet; the pain is still greater than the benefit.


Here's the list.

shrink count word
------ ----- ------------------------------
3166   1057  [[^_]]
2888    290  [ CONTROLLER]
1963    656  [UWVS]
1771    198  [ TECHNOLOG]
1758    881  [ IN]
1678    561  [TION]
1438    721  [ CO]
1268    255  [SYSTEM]
1126    189  [ BRIDGE]
1116    560  [PCI]
 994    167  [JOURNAL]
 986     53  [F 56K DATA/FAX/VOICE]
 964    323  [    ]
 932    468  [TER]
 870    110  [ ETHERNET]
 824    414  [ING]
 772    388  [DEV]
 745     84  [ELECTRONIC]
 742    249  [MODE]
 738    371  [POR]
 706    355  [ED ]
 706     60  [KERNEL: ASSER]
 643    216  [LOCK]
 592    298  [PRO]
 586    295  [ENT]
 554    279  [S: ]
 516    260  [REA]
 510    257  [IDE]
 496    167  [ABLE]
 478     81  [TRANSAC]
 474    239  [AGE]
 474    239  [NET]
 466    235  [ON ]
 464    234  [EXT]
 458    116  [CACHE]
 424    214  [<3>]
 418    106  [REGIS]
 416    210  [RES]
 415    140  [ LTD]
 415    140  [FAIL]
 414    209  [ %D]
 409    138  [DATA]
 394    199  [COM]
 394    133  [NOT ]
 390    197  [ARD]
 388    196  [E_R]
 386     98  [ ADAP]
 378    191  [FOR]
 374     95  [MICRO]
 373     16  [ ROAD RUNNER FRAME GRABBER]
 370    187  [SET]
 354    179  [VER]
 350    177  [ELE]
 348    176  [ALL]
 326    165  [100]
 318    161  [AND]
 312    158  [_IN]
 307    104  [TIME]
 306    155  [<6>]
 303     62  [AIC-78]
 298     26  [SEMICONDUCTOR]
 294    149  [SER]
 288    146  [AL ]
 288     59  [MEMORY]
 283     96  [%02X]
 282    143  [LIN]
 280    142  [ATE]
 273     56  [BUFFER]
 272    138  [TCP]
 270    137  [ %S]
 262     67  [AUDIO]
 258     66  [82801]
 256    130  [ECT]
 254     65  [ HOST]
 254    129  [PER]
 253     16  [08X %08X %08X %08X]
 250    127  [TO ]
 248    126  [OUN]
 248    126  [PHT]
 246     63  [C(%D)]
 246     32  [SMARTDAA)]
 244     42  [CANNOT ]
 244    124  [ORT]
 238    121  [9D$]
 238    121  [CHI]
 238     49  [F 56K ]
 238     21  [FIBRE CHANNEL]
 236    120  [T_R]
 234    119  [BIT]
 233     48  [MODULE]
 232    118  [CON]
 232    118  [NIC]
 230    117  [%LU]
 230     59  [POWER]
 230    117  [REE]
 226     58  [ERROR]
 215     32  [%U.%U.%U]
 215     32  [GRAPHICS]
 214    109  [EST]
 214     73  [NULL]
 214     73  [SOCK]
 212    108  [ALI]
 212    108  [TRI]
 210     54  [WRITE]
 208    106  [%08]
 202    103  [BUS]
 202     69  [GDT ]
 202     52  [GROUP]
 200    102  [<4>]
 200    102  [D$ ]
 200    102  [OUT]
 196     67  [FILE]
 196     67  [GET_]
 193     16  [ MIL-STD-1553 ]
 190     25  [ [APOLLO ]
 184     94  [ESS]
 182     47  [CHECK]
 182     93  [D$$]
 176     90  [STA]
 174     89  [AGP]
 174     45  [CYBER]
 173      8  [ABCDEFGHIJKLMNOPQRSTUVWXYZ]
 169     58  [TECH]
 168     86  [ RE]
 166     85  [82C]
 160     82  [000]
 160     82  [ACC]
 160     82  [END]
original size=232690, new size=154365


You may notice a goof my program makes.  The string "%U.%U.%U" appears 
in there, when what is actually found in the kernel is "%U.%U.%U.%U". 
 That's because there are more of the former, but only because the 
program didn't realize that pairs of the former overlap with each other. 
 I'll see about fixing that later, but really, I think we'll need to 
hand-pick strings anyhow.

Lastly, I decided to allow two-character strings to be encoded and upped 
the number of codes to 184.  This is the result:
original size=232690, new size=109133
That's a reduction of 53%.


