Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277599AbRKHS1P>; Thu, 8 Nov 2001 13:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277552AbRKHS04>; Thu, 8 Nov 2001 13:26:56 -0500
Received: from fc.capaccess.org ([151.200.199.53]:62470 "EHLO fc.Capaccess.org")
	by vger.kernel.org with ESMTP id <S277509AbRKHS0l>;
	Thu, 8 Nov 2001 13:26:41 -0500
Message-id: <fc.00858412001b2d4f00858412001b2d4f.1b2d8b@Capaccess.org>
Date: Thu, 08 Nov 2001 13:27:41 -0500
Subject: Son Of Shasm
To: mail2news-20011108-alt.os.assembly@anon.lcs.mit.edu
Cc: linux-kernel@vger.kernel.org
From: "Rick A. Hohensee" <rickh@Capaccess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rick Hohensee
rickh@capaccess.org
ftp://linux01.gwdg.de/pub/cLIeNUX

I just did or am about to post my current osimpa extension to the shasm
x86-assembler-in-Bash to alt.os.assembly. This may be the last public
domain version. Later versions will be available as source within cLIeNUX.
osimpa is starting to look fairly promising as a systems programming
method.

This is the application programming glossary
......................................................................

#       grep "()" osimpa
# stuff that makes for a good app-wirds glossary item has () in it.
# more obscure stuff is marked ( )                              ()
                                                                #()
# ASSEMBLER DIRECTIVES/HELPERS                                   ()
ab              () { # assemble bytes.  pass-sensitive.         =shasm
ao              () { # assemble one octal string as a byte      =shasm
ad              () { # assemble duals.   pass-sensitive.        =shasm
aq              () { # assemble quads. pass-sensitive quads     =shasm
ac              () { # assemble cells. pass-cell-sensitive.     =shasm
align           () { # like e.g. .align                         =shasm
allot           () { # relative .org, like Forth ALLOT          =shasm
asciibyte       () { # e.g.      ab  `asciibyte c q d`          =shasm
bases           () { # print # in decimal, binary, octal, hex   =shasm
binary          () { # binary <strings of ones and zeros>       =shasm
chom            () { # chom chomp  returns  chom                =shasm
homp            () { # homp chomp  is  homp                     =shasm
fillabsolute    () { # like .org, but fill to just BEFORE arg   =shasm
L               () { # label, set a branch bla at $here         =shasm
state           () { # write out entire current assembly state   =shasm
                                                                #()
# x86 general instructions                                      ()
=               () { # Copy. many variants, most freq. insn     -x86 MOV
1+              () { #  increment                               -x86 INC
1-              () { #  minus one, decrement                    -x86 DEC
/               () { # divide. 38 clocks.                       -x86 DIV
+               () { # add                                      -x86 ADD
+A              () { # add immediate to A, 32 bit only          -x86 ADD
+byte           () { # add immediate byte                       -x86 ADD
+carry          () { # add with carry.                          -x86 ADC
-               () { # subtract.                                -x86 SUB
-test           () { # do a subtract but save only the flags    -x86 CMP
-borrow         () { # dest - source - carry --> dest           -x86 SBB
AND             () { # Boolean bitwise AND                      -x86   =
ANDtest         () { # AND with no result but flags             -x86 TEST
NOT             () { # invert the bits                          -x86   =
OR              () { # Boolean bitwise OR                       -x86   =
XOR             () { # Boolean bitwise exclusive OR             -x86   =
biton           () { # set a particular bit to 1                -x86 BTS
bitoff          () { # set a particular bit to 0                -x86 BTR
call            () { # jump to subroutine, push return address  -x86 CALL
downroll        () { # down-significance bit-rotate             -x86 ROR
downshift       () { # down-significance bitshift, 0-fill high. -x86 SHR
extend          () { # sign-extend A to D:A                     -x86 CWD
fetches         () { # @ SI to A, scaled in/decr. SI, decr. C   -x86 LODSx
flags           () { #  copy  FLAGS into AX                     -x86 LAHF
jump            () { # unconditional branch                     -x86 JMP
linear          () { # x86 artifact quick address-math thingy   -x86 LEA
lookup          () { # byte lookup for e.g. ASCII->EBCDIC       -x86 XLATB
ls1bit          () { # bit number of least significant 1-bit    -x86 BSF
ms1bit          () { # bit number of most significant 1-bit     -x86 BSR
multiply        () { # arg * A --> D:A                          -x86 MUL
negate          () { # 2's-complement; Boolean NOT, then incr.  -x86 NEG
nop             () { # burn 3 clocks with no state effect       -x86 NOP
return          () { # return from a near call                  -x86 RET
setflags        () { # copy AH to the FLAGS register-half       -x86 SAHF
signedmultiply  () { # partial                                  -x86 IMUL
signeddivide    () { #                                          -x86 IDIV
swap            () { # swap two values.                         -x86 XCHG
uprollcarry     () { # up-significance bit roll through carry   -x86 RCL
uproll          () { #                                          -x86 ROL
upshift         () { #                                          -x86 SAL
when            () { # IF. conditional branch. Many variants.   -x86 jxx
widedownshift   () { # partial                                  -x86 SHRD
wideupshift     () { # partial                                  -x86 SHLD
within          () { # check value against 2 bounding values    -x86 BOUND
                                                                #()
# OSIMPA COMPEMBLER                                     ]]]]]   ()
ELF             () { # build simple but complete ELF header
osimpa          () { # main(). e.g. osimpa <your source file>
beam            () { # Fill a range of an xray with a jump address
cell            () { # name/allot a cell-size storage location
copyrange       () { # plural, range-to-range copy, handles overlaps
clump           () { # C struct() kinda, data associations namer
entrance        () { # name/begin a reentrant procedure
exuent          () { # return from the current reentrant procedure
fill            () { # plural, copies A across range @ DI       -x86 STOSD
flag            () { # assert the zero/sign flags of a register's value
go              () { # how you call an osimpa reentrant procedure
heap            () { # start uninititialized data sub-section
maskbyte        () { # mask arg down to a byte
maskdual        () { # mask arg down to it's lowest-significance 16 bits
match           () { # plural, range-range compare, zero flag=match
max             () { # inline, max bla zay  to zay
min             () { # inline, min bla zay   to zay
numbering       () { # C enum, but not strictly constants and no commas
quad            () { # name/allot a 4-byte storage location
quadtohex       () { # quad value to ASCII hexadecimal string
range           () { # name/allot some count-cell prefixed memory
scan            () { # plural, compare A to memory range @ DI until
hit/miss
strand          () { # name/allot a general array and 8 cells of metadata
sum             () { # plural, additive checksum
text            () { # name/allot some text
xjump           () { # indexed jump into an xray execution array
xray            () { # name an execution array for beam, yarx and xjump
xsum            () { # plural, XOR-ing checksum
yarx            () { # finish compembling an xray and it's beams
zero            () { # simple convenience to set a register to 0
                                                                # ()
# HOST OS DEPENDANT     ()
Linux           () { # syscalls, e.g.  Linux $read, many available
print           () { # write all of a range's net data to stdout
regspew         () { # raw binary register dump to stderr


............................................................................

This is a string scanner. It doesn't work right, but it geeks hard enough
indicate that osimpa is substantially working.

...........................................................................
let buffersize=4096
ELF

pull A                                          # let's go
-test 3 to A
  when not zero                 help            # demand 3 commandline
tokens
pull @ $programname                             # not used
pull @ $matchstring
pull @ $filename
=  @ $matchstring  to B                         # arg length via
subtraction
=  @ $filename   to A                           #       "
-  B to A                                       #       "
1- A                                            #     less the 0
1- A                                            #     less the first byte
=  A to @ $stringlength                         # KG
= @ $filename to B
zero C                                          # flags off for open
  Linux $open
flag A                                          # did it open?
  when sign                     problem
L per_read
        = 3 to B
        = $buffer to C
        = $buffersize to D
           Linux $read
        flag A
           when zero            exit_miss       # quit quietly
        = $buffer to DI
        = @ $matchstring to A
        = @ A to  A                             # byte to seek
        = $buffersize to C
L resume_bytescan
        scan
           when not zero per_read               # end of read with no hit
        push A                                  # byte hit, compare strings
        push C
        = @ $stringlength to C
        push DI
        = @ $matchstring to SI
        1+ SI                                   # we hit the first already
        match                                   # osimpa 10-insn composite
          when zero             hit
        pull DI
        pull C
        pull A
jump resume_bytescan

L exit_miss
        print $miss
                Linux $exit
L help
        print $helptext
                        Linux $exit
L hit
        print $wehit
                        Linux $exit
L problem
        print $nonfile
                        Linux $exit
text miss <<!
nope.
!
text helptext <<!
 Normally scan takes two arguments, a search string and a filename.  scan
checks a file for a literal string, e.g.
                scan bla somefile
                                        ... looks for "bla", and on the
first hit, scan prints the filename and quits, like grep -l. If it doesn't
hit it just quits. Thus it can be used in conjunction with "find" or a
shell for-loop to quickly search a set of files for a string.
!
text wehit <<!
        WE HIT
!
text nonfile <<!
scan couldn't open the given "filename", the second argument.
!
heap
cell matchstring
cell programname
cell stringlength
cell filename
L buffer
allot $buffersize
allot 100
.........................................................................


This is the interactive help you get from   when h    if you did
   . osimpa     in a Bash shell.
....................................................................

                                Intel jxx
 "when" is a wrapper for all the x86 conditional branches based on FLAGS
and also on the count register, C. "when" is used instead of "if" or
similar to not conflict with the shell, and I kinda like it subjectively.

when <not> <overflow> <<zero><carry>> <parity> <skew>
e.g.
        when not carry
                                                skew is when
sign<>overflow. The actual opcode is constructed from these
tokens/values... not=1 overflow=0 sign=8 carry=2 zero=4 parity=10 skew=12
and this is trivial to implement because that's how the actual opcode is
built, so it seems to kinda want to be this way.

BUT, There's MORE!(TM) I folded the variants of the Intel LOOP instruction
in here also. LOOP isn't a loop at all; it does forward branches just
fine. It is therefor when C-1 in osimpa, to imply that it performs the
decrement. There's also when C-1&zero and C-1&nonzero, which both also
decrement C before the test, and when C=0 which does NOT decrement C.
These latter when's only do short branches, but I haven't checked for the
branch width in the assembler. There are some thorny recursion issues with
figuring branch widths. The branches based on flags, i.e. not on C, can be
a byte or a cell. Cell (quad) is the default, and there's a "short"
token you can insert. I _COULD_ suss out backward branch widths without
that, but I haven't at this writing. Patches welcome. It seems the best
thing you can do for branch performance is rig your branches so the branch
is usually not taken, which is a bit better than a 2:1 win.



